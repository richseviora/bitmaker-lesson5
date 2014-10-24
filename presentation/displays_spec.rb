require 'rspec'
require_relative 'displays'
require_relative '../models/contact'


RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'Display Classes' do
  before :each do
    @contacts = []
    contacts_to_add = [
        {first_name: 'Rich', \
         last_name: 'Seviora', \
         id: '623292', \
         email: 'richard.seviora@gmail.com', \
         notes: 'Bearded.'}\
    , {first_name: 'Matt', \
       last_name: 'Schnarr', \
       id: '000123', \
       email: 'matt@gmail.com', \
       notes: 'Skinny.'}\
    , {first_name: 'Dan', \
       last_name: 'Cunningham', \
       id: '123456', \
       email: 'dan@gmail.com', \
       notes: 'Irish.'}
    ]
    contacts_to_add.each do |contact_to_add|
      new_contact = Contact.new(contact_to_add[:first_name], \
        contact_to_add[:last_name], contact_to_add[:id], \
        contact_to_add[:email], contact_to_add[:notes])
      @contacts << new_contact
    end
  end
  context 'Testing Display All Contacts' do
    before :each do
      @Class = Class.new
      @Class.include(ListAllContacts)
      @object = @Class.new
    end
    it 'Lists All Objects' do
      @object.list_all_contacts(@contacts)
    end

  end
  context 'Testing Display Contacts by Attribute' do
    before :each do

      @display = DisplayAttributes.new(@contacts)
    end

    it 'Lists Objects Properly' do
      STDOUT.should_receive(:puts).with('Rich')
      STDOUT.should_receive(:puts).with('Matt')
      STDOUT.should_receive(:puts).with('Dan')
      STDOUT.should_receive(:puts).with('Press Enter to Continue')
      expect(@display.display_all_contacts_by_attribute(:@first_name)).to be_truthy
    end
  end
  context 'Testing Ask For Attribute' do
    before :each do
      @Class = Class.new
      @Class.include(AttributeDisplay)
      @object = @Class.new
    end
    it 'Returns' do
      @object.ask_for_attribute('123456')
    end
  end

  context 'Modify Attributes' do
    before :each do
      @object = ModifyAttributes.new(nil)
    end
    it 'Returns the Key Value Pair' do
      @object.stub(:ask_for_attribute).and_return(:@first_name)
      @object.stub(:get_and_validate_input).and_return("Rich")
      expect(@object.handle_operations).to eq ({:@first_name => "Rich"})
    end
    it 'Returns Nil if Instructed to Quit' do
      @object.stub(:ask_for_attribute).and_return(:quit)
      @object.stub(:get_and_validate_input).and_return("Rich")
      expect(@object.handle_operations).to be_nil
    end

    it 'Returns Nil if Instructed to Quit' do
      @object.stub(:ask_for_attribute).and_return(:name)
      @object.stub(:get_and_validate_input).and_return(:quit)
      expect(@object.handle_operations).to be_nil
    end
  end

end
