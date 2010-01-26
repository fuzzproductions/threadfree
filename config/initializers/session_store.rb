# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_threadfree_session',
  :secret      => '187b666cd1df31ed0526508f5214dbdbc8c15d82fa67343e42192b2bd1f17bc4b1abcdf8b851e889018942beef52f0d539626acd17f828a0e6773cd292cc4795'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
