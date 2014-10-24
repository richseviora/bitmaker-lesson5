ADD_CONTACT_PROMPTS = {first_name: 'Enter the contact\'s first name:', last_name: 'Enter the contact\'s last name:', id: 'Enter the contact\'s ID:', email: 'Enter the contact\'s Email Address:', notes: 'Enter the contact\'s notes:'}

require_relative 'clearscreen'
class AddContactDisplay
  include CLEARSCREEN
  attr_reader


  # This method will display the input.
  def display_prompt(prompt)
    puts prompt
  end

  # This method will ask for and test the input. No validation has been requested outside of string length > 2. Returns nil if the input is invalid. Returns :quit if user types NO.
  def get_and_validate_input
    result = gets.chomp.strip
    case
      when result.length < 2
        return FALSE
      when result == 'NO'
        return :quit
      else
        return result
    end
  end

  # This method will ask for new values on each item.
  def ask_for_new_values
    clear_screen
    results = {}
    ADD_CONTACT_PROMPTS.each do |prompt, prompt_text|
      display_prompt(prompt_text)
      result = FALSE
      until result
        result = get_and_validate_input
        return nil if result == :quit
      end
      results[prompt] = result
    end
    return results
  end
end