# frozen_string_literal: true

class LtiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :launch # for lti integration
  after_action :allow_iframe, only: [:launch]

  def launch
    # If set, then hide the header and footer
    session[:isLTI] = true

    # create TP object with TC's key, corresponding secret in the config file, and other params sent by TC post request
    require 'oauth/request_proxy/action_controller_request'
    @provider = IMS::LTI::ToolProvider.new(
      params[:oauth_consumer_key],
      Rails.configuration.lti_settings[params[:oauth_consumer_key]],
      params
    )

    # if the provided secret by TC does not match the TP's corresponding secret, request is invalid
    # *****seems unable to handle GET request to the page /lti/launch*****
    unless @provider.valid_request?(request)
      render :launch_error, status: 401
      return
    end

    # check to see if the LTI post request from TC has a consumer key
    unless Rails.configuration.lti_settings[params[:oauth_consumer_key]]
      render :launch_error, status: 401
      return
    end

    # we have valid and authenticated LTI request
    # store params into class level instance variable for later
    @@launch_params = params
    @params = params

    # Look up User, Course, and Assignment for the Tool Consumer, or create if not in database
    # Note: normally this would be logging in user with authentication, but the LTI-LMS essentially does this
    # this means we can immediately take these params and direct someone to the study session
    @tool_consumer = ToolConsumer.create_with(product_family: params[:tool_consumer_info_product_family_code], name: params[:tool_consumer_instance_name]).find_or_create_by(guid: params[:tool_consumer_instance_guid])
    @tool_consumer.update(product_family: params[:tool_consumer_info_product_family_code], name: params[:tool_consumer_instance_name])

    @user = User.create_with(tool_consumer_id: @tool_consumer.id, roles: params[:roles], name: params[:lis_person_name_full]).find_or_create_by(tc_user_id: params[:user_id])
    @user.update(roles: params[:roles], name: params[:lis_person_name_full])
    if @user.review_setting.blank? && @user.roles == "Instructor"
      @user.create_review_setting
    end

    @course = Course.create_with(tool_consumer_id: @tool_consumer.id, context_title: params[:context_title], user_id: @user.id).find_or_create_by(context_id: params[:context_id])
    @course.update(context_title: params[:context_title])

    @assignment = Assignment.create_with(course_id: @course.id, resource_link_title: params[:resource_link_title], user_id: @user.id).find_or_create_by(resource_link_id: params[:resource_link_id])
    @assignment.update(resource_link_title: params[:resource_link_title])

    session[:user_id] = @user.id
    session[:course_id] = @course.id
    session[:assignment_id] = @assignment.id
    
    if params[:roles] == "Learner"
     
      # create course enrollment if first time accessing assignment in the course as a learner
      if @user.enrollments.where(course_id: @course.id).blank?
        @enrollment = Enrollment.create(user_id: @user.id, course_id: @course.id)
      # if course already exists, set it to instance variable
      else
        @enrollment = @user.enrollments.find_by(course_id: @course.id)
      end

      # create grade for the assignment if first time accessing assignment in the course as a learner. 
      # Save point scale, and assign student the deck and max score to begin.
      if @user.grades.where(enrollment_id: @enrollment.id, assignment_id: @assignment.id).blank?
        @grade = Grade.create(enrollment_id: @enrollment.id, assignment_id: @assignment.id, score: params[:custom_canvas_assignment_points_possible])
      #NOTE: no handling right now if the points possible in the assignment change, may need points_possible field, or consider using percents
      else
        @grade = @user.grades.find_by(assignment_id: @assignment.id)
      end

      # if learner does not have a deck account for this assigned deck, then create deck_account
      if @user.deck_accounts.where(deck_id: @assignment.deck.id).blank?
        @deck_account = DeckAccount.create(deck_id: @assignment.deck.id, user_id: @user.id, grade_id: @grade.id)
      else
        @deck_account = @user.deck_accounts.find_by(deck_id: @assignment.deck.id)
      end

      # redirect the user to the assignment if learner
      redirect_to course_assignment_path(@course, @assignment)
    else
      # redirect the user to the dashboard if instructor
      redirect_to dashboard_url
    end
  end

  def submitscore
    @tp = IMS::LTI::ToolProvider.new(@@launch_params[:oauth_consumer_key],
                                     Rails.configuration.lti_settings[@@launch_params[:oauth_consumer_key]],
                                     @@launch_params)
    # add extension
    @tp.extend IMS::LTI::Extensions::OutcomeData::ToolProvider

    unless @tp.outcome_service?
      @message = "This tool wasn't launched as an outcome service"
      puts "This tool wasn't launched as an outcome service"
      render(:launch_error)
    end

    # res = @tp.post_extended_replace_result!(score: params[:score])
    res = @tp.post_extended_replace_result!(score: 0.7)

    if res.success?
      puts 'Score Submitted'
    else
      puts 'Error during score submission'
    end
    redirect_to @@launch_params[:launch_presentation_return_url]
  end

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
