require 'factory_girl'


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  #these two lines let you add focus: true to an example group
  #and rspec will only run that, otherwise, run all examples
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

end
