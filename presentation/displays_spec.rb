require 'rspec'
require_relative 'displays'
require_relative '../models/contact'


RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'Display Classes' do
  context 'Testing Display Attributes' do
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
      @display = DisplayAttributes.new(@contacts)
    end

    it 'Returns' do
      @display.ask_for_attribute
    end

    it 'Handles Input 1' do
      @display.stub(:gets).and_return('1')
      expect(@display.ask_for_attribute).to eq :@first_name
    end

    it 'Lists Objects Properly' do
      STDOUT.should_receive(:puts).with('Rich')
      STDOUT.should_receive(:puts).with('Matt')
      STDOUT.should_receive(:puts).with('Dan')
      STDOUT.should_receive(:puts).with('Press Enter to Continue')
      expect(@display.display_all_contacts_by_attribute(:@first_name)).to be_truthy
    end
  end
end
