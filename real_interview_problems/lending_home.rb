# Used for namespacing
#
module RealInterviewProblems
  # Class
  #
  class LendingHome
    
    INTEGER_REGEX = /[1-9]/
    
    def initialize
      @server_id_host_type_mapping = {}
    end
    
    def next_server_num(input_arr)
      prep_next_server_num(input_arr)
    end
    
    def allocate(host_type)
      @server_id_host_type_mapping[host_type] ||= []
      server_num = prep_next_server_num(@server_id_host_type_mapping[host_type])
      @server_id_host_type_mapping[host_type] << server_num
      host_type + server_num.to_s
    end
    
    def deallocate(hostname)
      num_start_index = (hostname =~ /#{INTEGER_REGEX}/)
      puts num_start_index
      host_type = hostname[0...num_start_index]
      server_id = hostname[num_start_index...hostname.length].to_i
      @server_id_host_type_mapping[host_type].delete server_id
      nil
    end
    
    private
    
    # Another solution is to sort the input array and walk in a loop starting from 1 uptil
    # greatest number in array which will be at the last index in array. Check if each number
    # exists in array or not. If any number does not exist in array, return that number. Else
    # return the greatest number + 1. This has TC of O(nlogn) and needs no extra space
    #
    def prep_next_server_num(input_arr)
      return 1 if input_arr.empty?
      element_count_hash = {}
      max_num = 1
      input_arr.each do |element|
        max_num = element if max_num < element
        element_count_hash.merge!(element => 1)
      end
      next_server_num = nil
      (1..max_num).each do |num|
        unless element_count_hash.has_key? num
          next_server_num = num
          break
        end
      end
      return next_server_num unless next_server_num.nil?
      max_num + 1
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/real_interview_problems/lending_home'
# lending_home = RealInterviewProblems::LendingHome.new
# lending_home.next_server_num([1, 5, 4, 3])
# lending_home.next_server_num([2, 3])
# lending_home.next_server_num([3, 2, 1])
# lending_home.next_server_num([5, 4, 2, 1])
# lending_home.next_server_num([])
# lending_home.allocate('apibox')
# lending_home.allocate('apibox')
# lending_home.deallocate('apibox1')
# lending_home.allocate('sitebox')
# lending_home.deallocate('sitebox1')
