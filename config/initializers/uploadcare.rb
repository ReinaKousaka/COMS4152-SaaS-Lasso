require 'uploadcare'

Uploadcare.config.public_key = ENV["UPLOADCARE_PUBLIC_KEY"]
Uploadcare.config.secret_key = ENV["UPLOADCARE_SECRET_KEY"]