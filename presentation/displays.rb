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
      when result.to_i.between?(1,variables.count)
        return variables[result.to_i - 1]
      when result == "quit"
        return :quit
      else
        return nil
    end
  end
end

class AllContactDisplay
  include AttributeDisplay
  def display_all_contacts
    contacts.each { |contact| puts contact.describe }
    puts ''
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
    return nil if result == :quit

  end
end