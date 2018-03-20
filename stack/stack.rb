# Used for namespacing
#
module Stack
  # Class definition for stack
  #
  class Stack
    # Attribute Accessor
    #
    attr_accessor :arr, :curr

    # Initialize
    #
    def initialize
      @arr = []
      @curr = 0
    end

    # Adds an element to the stack and increases current pointer
    # @param value [Object]
    # @return [NIL]
    #
    def push(value)
      self.arr[self.curr] = value
      self.curr += 1
    end

    # Removes an element from stack and decreases current pointer
    # @return [Object]
    #
    def pop
      return nil if self.curr == 0
      val = self.arr[self.curr - 1]
      self.curr -= 1
      val
    end
    
    # Returns element at top without removing it
    # @return [Object]
    #
    def peek
	    return nil if self.curr == 0
	    self.arr[self.curr - 1]
    end

    # Returns true if no element exists in stack
    # @return [TrueClass/FalseClass]
    #
    def empty?
      return true if self.curr == 0
      false
    end
  end
end