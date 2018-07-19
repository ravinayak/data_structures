# Used for namespacing
#
module DynamicProgramming
  # Class
  #
  class GreatestNumberFromSet
    
    def initialize(arr)
      @arr = arr
    end
    
    def construct_greatest_num(arr)
      digits_arr = prep_digits_arr(arr)
      initial_hsh = prep_hash(digits_arr, index: 0)
      digits_hash = process_hash_of_digits(initial_hsh, index: 1)

      output_arr = []
      output_arr(digits_hash, output_arr: output_arr, index_hash: { index: 0 } )
      puts "Output Array :: #{output_arr.inspect}"
      puts "Greatest Number :: #{output_arr.flatten.join('')}"
      nil
    end
    
   private
    
    def output_arr(digits_hash, output_arr: , index_hash: )
      keys = (0..9).to_a.reverse
      keys.each do |key|
        next if digits_hash[key].nil?
        if digits_hash[key].is_a? Array
          output_arr[index_hash[:index]] = digits_hash[key].flatten.dup
          index_hash[:index] = index_hash[:index] + 1
        else
          output_arr(digits_hash[key], output_arr: output_arr, index_hash: index_hash)
        end
      end
    end
    
    def process_hash_of_digits(hsh, index:)
      (0..9).each do |digit|
        next if hsh[digit].nil?
        hsh[digit] = process_array(hsh[digit], index: index)
      end
      hsh
    end
    
    def process_array(arr, index:)
      return arr if arr.length == 1
      return arr if arr.all? { |elem_arr| index >= elem_arr.length }
      hsh = {}
      arr.each do |elem_arr|
        if elem_arr.length <= index
          hsh[elem_arr[elem_arr.length - 1]] ||= []
          hsh[elem_arr[elem_arr.length - 1]] << elem_arr
        else
          hsh[elem_arr[index]] ||= []
          hsh[elem_arr[index]] << elem_arr
        end
      end
      hsh = process_hash_of_digits(hsh, index: index + 1)
    end
    
    def prep_hash(arr, index:)
      hsh = {}
      arr.each do |elem_arr|
        hsh[elem_arr[0]] ||= []
        hsh[elem_arr[0]] << elem_arr
      end
      hsh
    end
    
    def prep_digits_arr(arr)
      digits_arr = []
      arr.each do |num|
        tmp = []
        while num != 0
          tmp << num % 10
          num = num / 10
        end
        digits_arr << tmp.reverse
      end
      digits_arr
    end
  end
end

# To run Greatest Number From Set problem
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/greatest_number_from_set'
# arr = [5, 543, 548, 520, 532, 987, 9, 98, 565, 556]
# greatest_num = DynamicProgramming::GreatestNumberFromSet.new(arr)
# greatest_num.construct_greatest_num(arr)
#
