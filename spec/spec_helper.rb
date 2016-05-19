require "simplecov"
SimpleCov.start 'rails'

RSpec.configure do |config|
  config.mock_with :mocha
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

require "paperclip/media_type_spoof_detector"
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
