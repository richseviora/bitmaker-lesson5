require_relative 'clearscreen'

module AttributeDisplay
  def ask_for_attribute(object)
    puts "Available Attributes: "
    variables = object.instance_variables
    variables.each_with_index do |variable, index|
      puts "#{index + 1}: #{variable}"
    end
    print "Enter Selection:"
    result = gets.chomp
    case
      when result.to_i.between?(1, variables.count)
        return variables[result.to_i - 1]
      when result == "quit"
        return :quit
      else
        return nil
    end
  end
end

module ListAllContacts
  def list_all_contacts(contacts)
    contacts.each_with_index { |contact, index| puts "#{index+1} #{contact.describe}" }
    puts ''
  end
end

class AllContactDisplay
  include AttributeDisplay
  include ListAllContacts

  def display_all_contacts
    list_all_contacts(@contacts)
    puts 'Press ENTER to Continue:'
    gets.chomp
  end

  def initialize(contacts)
    @contacts = contacts
  end
end

class DisplayAttributes
  include AttributeDisplay

  def initialize(contacts)
    @contacts = contacts
  end

  def handle_operations
    result = FALSE
    contact_object = @contacts.first
    until result
      result = ask_for_attribute(contact_object)
    end
    return nil if result == :quit
    display_all_contacts_by_attribute(result)
  end


  def display_all_contacts_by_attribute(attribute)
    @contacts.each { |contact| puts contact.instance_variable_get(attribute) }
    puts "Press Enter to Continue"
    gets.chomp
  end

end

class ModifyAttributes
  include AttributeDisplay
  include CLEARSCREEN

  def initialize(contact)
    @contact = contact
  end

  def get_and_validate_input(attribute)
    clear_screen
    puts "Current Attribute Value: #{@contact.instance_variable_get(attribute)}"
    print "Enter New Instance Value: "
    result = gets.chomp
    if result.length < 2
      nil
    elsif result == "NO"
      :quit
    else
      result
    end
  end

  def handle_operations
    attribute = nil
    until attribute
      attribute = ask_for_attribute(@contact)
    end
    return nil if attribute == :quit
    result = nil
    until result
      result = get_and_validate_input(attribute)
    end
    return nil if result == :quit
    {attribute => result}
  end
end

class DisplaySpecificContact
  include ListAllContacts

  def initialize(contacts)
    @contacts = contacts
  end

  def choose_contact
    list_all_contacts(@contacts)
    print 'Enter Contact Number'
    choice = gets.chomp
    if choice.to_i.between?(1, @contacts.count)
      return @contacts[choice.to_i - 1]
    elsif choice == 'NO'
      return :quit
    else
      return nil
    end
  end

  def display_contact(contact)
    puts contact.describe
  end

  def handle_operations
    contact_selected = nil
    until contact_selected
      contact_selected = choose_contact
    end
    return nil if contact_selected == :quit
    display_contact(contact_selected)
  end
end
