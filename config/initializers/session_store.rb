# config/initializers/session_store.rb
Rails.application.config.session_store(:cookie_store, same_site: :none, secure: true)
