class LtiController < ApplicationController
  after_action :allow_iframe, only: [:launch]
  
  def launch
    #If set, then hide the header and footer
    session[:isLTI]=true

    #check to see if the LTI post request from TC has a consumer key
    if not Rails.configuration.lti_settings[params[:oauth_consumer_key]]
      render :launch_error, status: 401
      return
    end

    #create TP object with TC's key, corresponding secret in the config file, and other params sent by TC post request
    @authenticator = IMS::LTI::Services::MessageAuthenticator.new(request.url, request.request_parameters, Rails.configuration.lti_settings[params[:oauth_consumer_key]])

    # if the provided secret by TC does not match the TP's corresponding secret, request is invalid
    if not @authenticator.valid_signature?
      render :launch_error, status: 401
      return
    end

    #we have valid and authenticated LTI request
    #store params into instance variance
    @launch_params = params;
    # email = params[:lis_person_contact_email_primary]

    #Request was valid, Now find or create user, along with the deck
    # @user = User.where(email: email).first
    # if @user.blank?
    #   @user = User.new(:username => email,
    #                    :email => email,
    #                    :password => email,
    #                    :password_confirmation => email)
    #   if !@user.save
    #     puts @user.errors.full_messages.first
    #   end
    # end

    #Login the user and create his session.
    # authorized_user = User.authenticate(email,email)
    # authorized_user = User.find_by_email(email)
    # session[:user_id] = authorized_user.id
    #redirect the user to give quiz starting from question id 1
    # redirect_to(:controller => "static", :action => "landing_page")
  end

  def submitscore
    @tp = IMS::LTI::ToolProvider.new(@@launch_params[:oauth_consumer_key],
    Rails.configuration.lti_settings[@@launch_params[:oauth_consumer_key]],
    @@launch_params)
    # add extension
    @tp.extend IMS::LTI::Extensions::OutcomeData::ToolProvider

    if !@tp.outcome_service?
      @message = "This tool wasn't launched as an outcome service"
      puts "This tool wasn't launched as an outcome service"
      render(:launch_error)
    end

    res = @tp.post_extended_replace_result!(score: params[:result])

    if res.success?
      puts "Score Submitted"
    else
      puts "Error during score submission"
    end
    redirect_to @@launch_params[:launch_presentation_return_url]
  end

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
