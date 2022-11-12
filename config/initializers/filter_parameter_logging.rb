# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :authenticity_token]
# https://guides.rubyonrails.org/configuring.html#rails-general-configuration
# filter :authenticity_token out of logs