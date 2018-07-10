# Used for namespacing
#
module Backtracking
  # Class
  #
  class BeautifulArrangement
  
    attr_accessor :count, :output_hash
  
    def initialize
      @count = 0
      @output_hash = []
    end
  
    def generate_arrangements(num)
      return @output_hash[num] unless @output_hash[num].nil?
      visited, arr, output_arr = [], [], []
      calculate(num: num, pos: 1, visited: visited, arr: arr, index: 0, output_arr: output_arr)
      @output_hash[num] = output_arr
      [@count, @output_hash[num]]
    end
  
    def calculate(num: , pos: , visited: , arr: , index: , output_arr:)
      if pos > num
        @count += 1
        output_arr << arr[0...index].join
      end
    
      (1..num).each do |i|
        if !visited[i] && (pos % i == 0 || i % pos == 0)
          visited[i] = true
          arr[index] = i
          calculate(num: num, pos: pos + 1, visited: visited, arr: arr, index: index + 1, output_arr: output_arr)
          visited[i] = false
        end
      end
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/beautiful_arrangement'
# num = 3
# bt = Backtracking::BeautifulArrangement.new
# bt.generate_arrangements(num)
