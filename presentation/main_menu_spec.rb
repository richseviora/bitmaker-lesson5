require 'rspec'
require File.dirname(__FILE__) + '/main_menu'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'Main_Menu_Testing' do
  before :each do
    @main_menu = MainMenu.new
  end

  it 'Responds to Add New Contact Requests' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('1')
    expect(@main_menu.ask_for_choice).to eq(:add_new_contact)
  end

  it 'Responds to Modify Contact Requests' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('2')
    expect(@main_menu.ask_for_choice).to eq(:modify_contact)
  end

  it 'Responds to Modify Contact Requests' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('3')
    expect(@main_menu.ask_for_choice).to eq(:delete_contact)
  end

  it 'Responds to Display All Contacts' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('4')
    expect(@main_menu.ask_for_choice).to eq(:display_all_contacts)
  end

  it 'Responds to Display an Attribute' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('5')
    expect(@main_menu.ask_for_choice).to eq(:display_an_attribute)
  end

  it 'Responds to Exit' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('6')
    expect(@main_menu.ask_for_choice).to eq(:exit)
  end

  it 'Responds to Invalid Input' do
    STDOUT.should_receive(:puts).with("\e[H\e[2J")
    @main_menu.menu_choices.each { |menu_choice| STDOUT.should_receive(:puts).with(menu_choice)}
    @main_menu.stub(:gets).and_return('Bob')
    @main_menu.stub(:gets).and_return('1')
    expect(@main_menu.ask_for_choice).to eq(:add_new_contact)
  end
end