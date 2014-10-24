class AllContactDisplay
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
  def initialize(contacts)
    @contacts = contacts
  end

  def handle_operations
    result = FALSE
    until result
      ask_for_attribute
    end
    return nil if result == :quit
    display_all_contacts_by_attribute(result)
  end

  def ask_for_attribute
    contact_object = @contacts.first
    variable_count = 0
    puts "Available Attributes: "
    variables = contact_object.instance_variables
    variables.each do |variable|
      variable_count += 1
      puts "#{variable_count}: #{variable}"
    end
    print "Enter Selection:"
    result = gets.chomp
    case
      when result.to_i.between?(1,variable_count)
        return variables[result.to_i - 1]
      when result == "quit"
        return :quit
      else
        return nil
    end
  end

  def display_all_contacts_by_attribute(attribute)
    @contacts.each { |contact| puts contact.instance_variable_get(attribute) }
    puts "Press Enter to Continue"
    gets.chomp
  end

end

