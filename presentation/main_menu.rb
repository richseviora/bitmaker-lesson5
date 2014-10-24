=begin
The main menu class will be responsible for returning the user's choice to the interaction manager.
=end

require File.dirname(__FILE__) + '/clearscreen'

class MainMenu
  include CLEARSCREEN
  attr_reader :menu_choices

  def initialize
    @menu_choices = ['[1] Add a new contact', '[2] Modify an existing contact',
                     '[3] Delete a contact', '[4] Display all the contacts',
                     '[5] Display an attribute', '[6] Display a contact', '[7] Exit', 'Enter a number: ']
  end

  def display_menu
    @menu_choices.each { |menu_choice| puts menu_choice }
  end

  def ask_for_choice
    valid_choice = FALSE
    until valid_choice
      display_menu
      decision = parse_input(gets.chomp)
      valid_choice = TRUE if decision != :invalid
      clear_screen
    end
    return decision
  end

  def parse_input(input_string)
    case input_string
      when '1'
        return :add_new_contact
      when '2'
        return :modify_contact
      when '3'
        return :delete_contact
      when '4'
        return :display_all_contacts
      when '5'
        return :display_an_attribute
      when '6'
        return :display_a_contact
      when '7'
        return :exit
      else
        return :invalid
    end
  end

end

