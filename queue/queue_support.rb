# Used for namespacing
#
module Queue
  # Includes support methods for Queue
  #
  module QueueSupport
    # Constant to hold messages, characters and length
    #
    QUEUE_FULL = 'Queue is full. Cannot add any element'
    QUEUE_EMPTY = 'Queue is empty. No element to remove'
    LENGTH = 1000
    EMPTY_CHAR = '$'

    # Support method for adding an element to Queue
    # @param value [Integer]
    #
    def add_element_support(value)
      return QUEUE_FULL if full_support?
      self.rear = 0 if self.rear == LENGTH
      self.arr[rear] = value
      self.rear += 1
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
      front_rear_equal?
    end

    # Returns true if Queue is empty
    # @return [TrueClass/FalseClass]
    #
    def empty_support?
      return false if self.front == 0 && self.rear == LENGTH
      return false unless self.front == self.rear
      !front_rear_equal?
    end

    # Prints elements in Queue
    # @return [NIL]
    #
    def print_queue_support
      print QUEUE_EMPTY if empty_support?
      met_resp = prep_min_max
      min, max = met_resp[:min], met_resp[:max]
      max_elem = max - 1
      (min..max_elem).each { |x| print x + ' ' }
      (0..(self.rear - 1)).each { |x| print x + ' ' } if max == LENGTH
    end

    # Determines min and max based on front and rear values to define
    # range of values for iterating in array
    # @return [Hash]
    #
    def prep_min_max
      diff = self.rear - self.front

      case diff

      when diff > 0
        min, max = self.front, self.rear
        return { min: min, max: max }
      when diff < 0
        min, max = self.front, LENGTH
        return { min: min, max: max }
      when diff == 0
        min, max = self.front, LENGTH
        return { min: min, max: max }
      else
        { min: nil ,max: nil }
      end
    end

    # Evaluates cases where front and rear are at same locations in
    # an array. In this case, the queue is either full or empty
    # @return [TrueClass/FalseClass]
    #
    def front_rear_equal?
      case self.front

      when 0
        return rear_front_at_one?

      when LENGTH
        return rear_front_at_len?

      else
        return rear_front_not_ext?
      end
    end

    # Evaluates if queue is full when front and rear are at 0
    # @return [TrueClass/FalseClass]
    #
    def rear_front_at_one?
      return true if self.arr[self.front + 1] == EMPTY_CHAR
      false
    end

    # Evaluates if queue is full when front and rear are at 0
    # @return [TrueClass/FalseClass]
    #
    def rear_front_at_len?
      return true if self.arr[0] == EMPTY_CHAR
      false
    end

    # Evaluates if queue is full when front and rear are at 0
    # @return [TrueClass/FalseClass]
    #
    def rear_front_not_ext?
      return true unless self.arr[self.rear +  1] == EMPTY_CHAR
      false
    end
  end
end