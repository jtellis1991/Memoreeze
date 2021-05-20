Rails.application.routes.draw do
 
get "xml", :to => "static#xml"
get 'static/landing_page'

get 'lti/launch'
post 'lti/launch'

end
