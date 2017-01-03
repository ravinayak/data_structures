require_relative '../queue_implementation/queue_support'

# Used for namespacing
#
module QueueImplementation
  # Class definition
  #
  class QueueImplementation
    # Includes module
    #
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

# Code to create a queue and add nodes to it
# Print Queue
#
# require '/Users/ravinayak/projects/data_structures/queue_implementation/queue_implementation'
# queue = QueueImplementation::QueueImplementation.new
# (1..1000).each { |val| queue.add_element(val) }
# http://twomovies.net/full_movie/124/1355644/1/movie/#confirmed
#