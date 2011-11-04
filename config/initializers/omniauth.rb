Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, :fields => [:first_name, :last_name], :uid_field => :last_name
  provider :github, 'CLIENT_ID', 'SECRET_ID'
end
