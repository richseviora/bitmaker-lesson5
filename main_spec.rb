require 'rspec'
require_relative 'main'
require_relative 'models/rolodex'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end


describe 'CRM Operations' do
  before :each do
    @instance = CRM.new
    @instance.main_menu = double('main_menu')
  end
  it 'should Respond to Exit' do
    allow(@instance.main_menu).to receive(:ask_for_choice) { :exit }
    @instance.handle_operations
  end
  it 'Should Raise when Sent Invalid Symbol' do
    allow(@instance.main_menu).to receive(:ask_for_choice) { :bob }
    expect { @instance.handle_operations }.to raise_error
  end
  it 'Should Send to Add New Contact' do
    allow(@instance.main_menu).to receive(:ask_for_choice) { :bob }
    expect { @instance.handle_operations }.to raise_error
  end

  context 'Creating a New Contact' do
    before :each do
      @add_new_contact_display = double('add display')
    end
    it 'Adds a New Contact' do
      @add_new_contact_display.stub(:ask_for_new_values).and_return(double('contact'))
      expect(@instance.add_new_contact)
      expect(@instance.rolodex.contacts.count).to eq 1
    end
  end

end
