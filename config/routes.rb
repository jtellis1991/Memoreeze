# frozen_string_literal: true

Rails.application.routes.draw do
  get 'xml', to: 'static#xml'

  get 'lti/launch'
  post 'lti/launch'

  get 'lti/submitscore'
  post 'lti/submitscore'
end
