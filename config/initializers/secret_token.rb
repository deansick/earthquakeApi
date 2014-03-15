# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
EarthquakeAPI::Application.config.secret_token = ENV['SECRET_TOKEN']
# EarthquakeAPI::Application.config.secret_key_base = '58126cf5c1f3599c96236c2203aaee170151dfab46c71efd44d6c824ecade4b9dc2cc78715f67dc7033904e05f649df6e229fe121af91175b8a7c8aa78901af9'
