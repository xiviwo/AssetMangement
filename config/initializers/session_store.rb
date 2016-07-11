# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_info_session',
  :secret      => 'b68fd381e0b1d83a4379c84497ec337f4e4195b19b860d8d26429b4851ae068de1c0d0f067214dc0701d7c0a4a8fb986fa2cd35f46ec42ad354ac11a1d86c798'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
