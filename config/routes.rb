# frozen_string_literal: true

Rails.application.routes.draw do
  resources :targets
  resources :review_settings
  resources :results
  resources :decks
  resources :reviews
  resources :cards
  resources :tool_consumers
  resources :grades
  resources :assignments
  resources :enrollments
  resources :courses
  resources :users
  
  #forced route to default to xml. Thanks Jelani!
  get 'config.xml', to: 'static#xml_config', :defaults => { :format => 'xml'}

  get 'launch', to: 'lti#launch'
  post 'launch', to: 'lti#launch'

  get 'lti/submitscore'
  post 'lti/submitscore'
end
