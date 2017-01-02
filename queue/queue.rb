require_relative '../queue/queue_support'

# Used for namespacing
#
module Queue
  # Class definition
  #
  class Queue
    # Includes module
    include QueueSupport

    # Attribute Accessor
    #
    attr_accessor :front, :rear, :arr

    # Initialize
    #
    def initialize
      @front = 0
      @rear = 0
      @arr = []
    end

    # Public methods
    #
    # Adds an element to Queue
    # @param value [Integer]
    #
    def add_element(value)
      add_element_support(value)
    end

    # Removes an element from Queue
    # @return [Integer]
    #
    def remove_element
      remove_element_support
    end

    # Returns true if Queue is full
    # @return [TrueClass/FalseClass]
    #
    def full?
      full_support?
    end

    # Returns true if Queue is empty
    # @return [TrueClass/FalseClass]
    #
    def empty?
      empty_support?
    end

    # Prints elements in Queue
    # @return [NIL]
    #
    def print_queue
      print_queue_support
    end
  end
end