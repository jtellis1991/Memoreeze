# frozen_string_literal: true

class LtiController < ApplicationController
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
    # *****seems unable to handle get request to the page /lti/launch*****
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
    @tool_consumer = ToolConsumer.find_or_create_by(guid: params[:tool_consumer_instance_guid])
    @user = User.create_with(tool_consumer_id: @tool_consumer.id, role: params[:roles]).find_or_create_by(tc_user_id: params[:user_id])
    @course = Course.create_with(tool_consumer_id: @tool_consumer.id).find_or_create_by(context_id: params[:context_id])
    @assignment = Assignment.create_with(course_id: @course.id).find_or_create_by(resource_link_id: params[:resource_link_id])
    
    # Store the user in the session
    session[:user_id] = @user.id

    # redirect the user to the assignment
    redirect_to assignment_url(@assignment)
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
