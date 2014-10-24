require 'rspec'
require_relative 'add_contact_display'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'Add Contact Display' do
  before :each do
    @add_contact_display = AddContactDisplay.new
  end

  it 'Should Ask For Input' do
    ADD_CONTACT_PROMPTS.each do |symbol, prompt|
      STDOUT.should_receive(:puts).with(prompt)
    end
    @add_contact_display.stub(:gets).and_return('Bob')
    @add_contact_display.ask_for_new_values
  end

  it 'Should return a valid result' do
    expected_result_for_bob = {first_name: 'Bob', last_name: 'Bob', id: 'Bob', email: 'Bob', notes: 'Bob'}
    @add_contact_display.stub(:gets).and_return('Bob')
    expect(@add_contact_display.ask_for_new_values).to eq(expected_result_for_bob)
  end

  it 'Should Return Nil if user Types NO' do
    @add_contact_display.stub(:gets).and_return('NO')
    expect(@add_contact_display.ask_for_new_values).to be_nil
  end

end

