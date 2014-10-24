require_relative 'presentation/displays'
require_relative 'presentation/main_menu'
require_relative 'presentation/add_contact_display'
require_relative 'models/rolodex'
require_relative 'models/contact'


class CRM
  attr_accessor :main_menu, :rolodex
  def initialize
    @main_menu = MainMenu.new
    @rolodex = Rolodex.new
  end

  def add_new_contact
    display = AddContactDisplay.new
    new_contact_results = display.ask_for_new_values
    if new_contact_results
      new_contact = Contact.new(new_contact_results[:first_name],new_contact_results[:last_name],new_contact_results[:id],new_contact_results[:email],new_contact_results[:notes])
      @rolodex.add_contact(new_contact)
      puts "New Contact Added #{@rolodex.contacts.count}"
    end
  end

  def display_all_contacts
    display = AllContactsDisplay.new(@rolodex.contacts)
    display.display_all_contacts
  end

  def display_an_attribute
    display = DisplayAttributes.new(@rolodex.contacts)
    display.handle_operations
  end

  def handle_operations
    exit_requested = FALSE
    until exit_requested
      choice = @main_menu.ask_for_choice
      case choice
        when :add_new_contact
          add_new_contact
        when :modify_contact

        when :display_a_contact
          raise 'Not Implemented'
        when :delete_contact
          raise 'Not Implemented'
        when :display_all_contacts
          display_all_contacts
        when :display_an_attribute
          display_an_attribute
        when :exit
          exit_requested = TRUE
        else
          raise "Invalid Choice Presented #{choice}"
      end
    end
  end
end

instance = CRM.new
instance.handle_operations

