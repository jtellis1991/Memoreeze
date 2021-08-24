# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token, only: :launch
  # after_action :allow_iframe
  before_action :set_user
  # def allow_iframe
  #   response.headers.except! 'X-Frame-Options'
  # end
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
end
