require 'rspec/expectations'

RSpec::Matchers.define :match_hash do |expected|
  match do |actual|
    expect(JSON.pretty_generate(actual).strip).to eq(JSON.pretty_generate(expected).strip)
  end

  diffable
end
