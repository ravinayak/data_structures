require_relative '../backtracking/permutations_combinations'
# Used for namespacing
#
module Backtracking
  # Class Exception
  #
  class InvalidInputException < Exception
  end
  # Class
  #
  class RestoreIpAddress
    
    def initialize(ip_str: nil)
      @ip_str = ip_str
    end
    
    def generate_valid_ip_addr(ip_str)
      prep_valid_ip_addr(ip_str)
    end
    
    
    private
    
    def prep_valid_ip_addr(ip_str)
      raise InvalidInputException, 'Input is invalid' if ip_str.length < 4 || ip_str.length > 12
      
      arr = (1...ip_str.length).reduce([]) { |accumulator, element| accumulator << element }
      bt = Backtracking::PermutationsCombinations.new(arr)
      # We need three partitions to have four parts, one for each segment of IP Address
      # Take combinations of 3 out of elements of array
      # For each combination, take substring of ip address starting from 0 to 1st element in array,
      # then substring from 2nd element of array to 3rd element, and so on, until last element of array to length of
      # string. Each segment is separated by a "."
      #
      partition_index_arr = bt.generate_combinations(arr, 3)

      ip_str_arr = []
      partition_index_arr.each do |partition_arr|
        possible_ip_str = ip_str[0...partition_arr[0]] + '.' + ip_str[partition_arr[0]...partition_arr[1]] + '.' +
          ip_str[partition_arr[1]...partition_arr[2]] + '.' + ip_str[partition_arr[2]...ip_str.length]
        ip_str_arr << possible_ip_str if is_ip_segment_valid?(possible_ip_str)
      end
      ip_str_arr
    end
    
    def is_ip_segment_valid?(ip_str)
      return false if ip_str.split('.').any? { |ip_segment| ip_segment.to_i < 0 || ip_segment.to_i > 255 }
      true
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/restore_ip_address'
# restore = Backtracking::RestoreIpAddress.new
# ip_str = '25525511135'
# restore.generate_valid_ip_addr(ip_str)
