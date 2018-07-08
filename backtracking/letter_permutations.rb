# Used for namespacing
#
module Backtracking
  # Exception Class
  #
  class KeyPadLetterException < Exception
  
  end
  # Class
  #
  class LetterPermutations
    
    DIGIT_KEY_HASH = {
      2 => %w(a b c),
      3 => %w(d e f),
      4 => %w(g h i),
      5 => %w(j k l),
      6 => %w(m n o),
      7 => %w(p q r s),
      8 => %w(t u v),
      9 => %w(w x y z)
    }
    
    def generate_perm_keypad_str(keypad_str)
      raise KeyPadLetterException.new, 'Input is invalid' if
        keypad_str.chars.any? { |c| !(2..9).to_a.include?(c.to_i) }
      
      arr = []
      prep_perm_keypad_str(keypad_str: keypad_str, output_str: [], index: 0, arr: arr)
      puts "Array of Letter Permutations :: #{arr.inspect}"
      puts "Number of Letter Permutations :: #{arr.length}"
      nil
    end
    
    private
    
    def prep_perm_keypad_str(keypad_str: , output_str: , index: , arr: arr)
      if index == keypad_str.length
        arr << output_str[0...keypad_str.length].join
        return
      end
      num = keypad_str[index].to_i
      DIGIT_KEY_HASH[num].each do |letter|
        output_str[index] = letter
        prep_perm_keypad_str(keypad_str: keypad_str, output_str: output_str, index: index + 1, arr: arr)
      end
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/letter_permutations'
# num = '23'
# bt = Backtracking::LetterPermutations.new
# bt.generate_perm_keypad_str(num)
