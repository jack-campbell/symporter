# Load the Rails application.
require File.expand_path('../application', __FILE__)

Paperclip::Attachment.default_options[:url] = "/system/:class/:attachment/:id/:style/:filename"
# Initialize the Rails application.
Rails.application.initialize!
