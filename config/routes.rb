# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tool_consumers
  resources :grades
  resources :assignments
  resources :enrollments
  resources :courses
  resources :users
  
  get 'config.xml', to: 'static#xml_config'

  get 'launch', to: 'lti#launch'
  post 'launch', to: 'lti#launch'

  get 'lti/submitscore'
  post 'lti/submitscore'
end
