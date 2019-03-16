require 'simple_approvals/rspec'

describe 'simple_approvals/rspec' do
  # if 'spec/fixtures/should_approve_results' does not exist
  # you will see something like:
  # Failures:
  #
  #  1) simple_approvals/rspec should approve results
  #  Failure/Error: ::RSpec::Expectations.fail_with message, expected_content, received_content
  #
  #    Approval failed to match "spec/fixtures/should_approve_results"
  #    - writing received content to: "spec/fixtures/should_approve_results.received"
  #   ./lib/simple_approvals/rspec/approvals.rb:65:in `raise_verify_error_with_diff'
  #   ./lib/simple_approvals/rspec/approvals.rb:16:in `verify'
  #   ./spec/approvals_spec.rb:6:in `block (2 levels) in <top (required)>'
  #
  # rename the generated 'spec/fixtures/should_approve_results.received'
  # to the expected path 'spec/fixtures/should_approve_results'
  # to represent that this is the "approved" version and the test will pass.
  #
  it 'should approve results' do
    some_test_output = "Shiny, cap'n!"
    Approvals.verify(some_test_output, 'spec/fixtures/should_approve_results')
  end

  # if you don't have the expected 'spec/fixtures/can_auto_approve_results' file
  # or you have it but with different content and you know that you want to
  # approve the new content you can add an "approve_all: true" argument and the
  # content being verified will be pre-written to the approved path so that the
  # compare will come out positive.
  #
  it 'can auto-approve results' do
    some_test_output = "who's flying this thing?"
    Approvals.verify(some_test_output, 'spec/fixtures/can_auto_approve_results', approve_all: true)
  end
end
