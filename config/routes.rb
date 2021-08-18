# frozen_string_literal: true

Rails.application.routes.draw do
  resources :targets
  resources :review_settings
  resources :results
  resources :reviews
  resources :tool_consumers
  resources :grades
  resources :enrollments
  resources :users

  resources :decks do
    resources :cards
  end

  resources :courses do
    resources :assignments
  end

  
  
  #forced route to default to xml. Thanks Jelani!
  get 'config.xml', to: 'static#xml_config', :defaults => { :format => 'xml'}

  get 'launch', to: 'lti#launch'
  post 'launch', to: 'lti#launch'

  get 'lti/submitscore'
  post 'lti/submitscore'

  get "courses/:course_id/assignments/:id/deck/edit" => "assignments#edit_deck"

  get "decks/:id/name/edit", to: "decks#edit_name"
  patch "decks/:id/name", to: "decks#update_name"

  #Ajaxify links for editing fields in Cards
  get "decks/:deck_id/cards/:id/explanation/edit" => "cards#edit_explanation"
  get "decks/:deck_id/cards/:id/illustrative_test/edit" => "cards#edit_illustrative_test"
  get "decks/:deck_id/cards/:id/solution/edit" => "cards#edit_solution"
  get "decks/:deck_id/cards/:id/target/edit" => "cards#edit_target"
  get "decks/:deck_id/cards/:id/deck_name/edit" => "cards#edit_deck_name"

  #Ajaxify links for updating fields in Cards
  patch "/decks/:deck_id/cards/:id/solution", to: 'cards#update_solution'
  patch "/decks/:deck_id/cards/:id/explanation", to: 'cards#update_explanation'
  patch "/decks/:deck_id/cards/:id/illustrative_test", to: 'cards#update_illustrative_test'
  patch "/decks/:deck_id/cards/:id/target", to: 'cards#update_target'
  patch "/decks/:deck_id/cards/:id/deck_name", to: 'cards#update_deck_name'


  get 'dashboard', to: 'users#dashboard'
end
