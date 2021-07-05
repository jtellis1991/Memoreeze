# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, only: :launch
  after_action :allow_iframe

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
