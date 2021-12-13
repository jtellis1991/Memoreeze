# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token, only: :launch
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :set_user

  private

  def current_user
    @user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def current_assignment
    @assignment ||= session[:assignment_id] && Assignment.find_by(id: session[:assignment_id])
  end

  def current_course
    @course ||= session[:course_id] && Course.find_by(id: session[:course_id])
  end

  def set_user
    @user = current_user
  end

  def set_time_zone
    @time_zone = current_assignment.user.review_setting.time_zone
  end

  def today 
    @time_zone = set_time_zone
    Time.now.in_time_zone(@time_zone).to_date
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
