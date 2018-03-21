# Used for namespacing
#
module QueueImplementation
  # Includes support methods for Queue
  #
  module QueueSupport
    # Constant to hold messages, characters and length
    #
    QUEUE_FULL = 'Queue is full. Cannot add any element'
    QUEUE_EMPTY = 'Queue is empty'
    LENGTH = 1000
    EMPTY_CHAR = '$'

    # Support method for adding an element to Queue
    # @param value [Integer]
    #
    def add_element_support(value)
      return print QUEUE_FULL if full_support?
      self.rear = 0 if self.rear == LENGTH
      self.arr[rear] = value
      self.rear += 1
      value
    end

    # Support method for removing an element from Queue
    # @return value [Integer]
    #
    def remove_element_support
      return QUEUE_EMPTY if empty_support?
      self.front = 0 if self.front == LENGTH
      elem = self.arr[self.front]
      self.arr[self.front] = EMPTY_CHAR
      self.front += 1
      elem
    end

    # Returns true if Queue is full
    # @return [TrueClass/FalseClass]
    #
    def full_support?
      return true if self.front == 0 && self.rear == LENGTH
      return false unless self.front == self.rear
      front_rear_equal?(:full)
    end

    # Returns true if Queue is empty
    # @return [TrueClass/FalseClass]
    #
    def empty_support?
      return false if self.front == 0 && self.rear == LENGTH
      return false unless self.front == self.rear
      front_rear_equal?(:empty)
    end

    # Prints elements in Queue
    # @return [NIL]
    #
    def print_queue_support
      return print QUEUE_EMPTY if empty_support?
      met_resp = prep_min_max
      min, max = met_resp[:min], met_resp[:max]
      max_elem = max - 1
      (min..max_elem).each { |x| print self.arr[x].to_s + ' ' }
      (0..(self.rear - 1)).each { |x| print self.arr[x].to_s + ' ' } if print_from_start?(min, max)
      nil
    end

    # Prints remaining elements in Queue from start
    # @param min [Integer]
    # @param max [Integer]
    # @return [TrueClass/FalseClass]
    #
    def print_from_start?(min, max)
      max == LENGTH && min != 0 && !empty_support? && !(self.arr[0] == EMPTY_CHAR)
    end

    # Determines min and max based on front and rear values to define
    # range of values for iterating in array
    # @return [Hash]
    #
    def prep_min_max
      diff = self.rear - self.front

      case diff
      when 1..LENGTH
        min, max = self.front, self.rear
        return { min: min, max: max }
      when -LENGTH..-1
        min, max = self.front, LENGTH
        return { min: min, max: max }
      when 0
        min, max = self.front, LENGTH
        return { min: min, max: max }
      else
        { min: nil, max: nil }
      end
    end

    # Evaluates cases where front and rear are at same locations in
    # an array. In this case, the queue is either full or empty
    # @param empty_full_sym [Symbol]
    # @return [TrueClass/FalseClass]
    #
    def front_rear_equal?(empty_full_sym)
      case self.front
      when 0
        return rear_front_at_one_not_ext?(empty_full_sym)
      when LENGTH
        return rear_front_at_len?(empty_full_sym)
      else
        return rear_front_at_one_not_ext?(empty_full_sym)
      end
    end

    # Evaluates if queue is full when front and rear are at 0 or not at extremes
    # @param empty_full_sym [Symbol]
    # @return [TrueClass/FalseClass]
    #
    def rear_front_at_one_not_ext?(empty_full_sym)
      case empty_full_sym
      when :empty
        return true if self.arr[self.front + 1].nil? || self.arr[self.front + 1] == EMPTY_CHAR
        return false
      when :full
        return true unless self.arr[self.front + 1].nil? || self.arr[self.front + 1] == EMPTY_CHAR
        return false
      else
        nil
      end
    end

    # Evaluates if queue is full when front and rear are at LENGTH
    # @param empty_full_sym [Symbol]
    # @return [TrueClass/FalseClass]
    #
    def rear_front_at_len?(empty_full_sym)
      case empty_full_sym
      when :empty
        return true if self.arr[0].nil? || self.arr[0] == EMPTY_CHAR
        return false
      when :full
        return true unless self.arr[0].nil? || self.arr[0] == EMPTY_CHAR
        return false
      else
        nil
      end
    end
  end
end