require_relative '../linked_list/node'
require_relative '../linked_list/linked_list_support'

# Used for namespacing
#
module LinkedList
  # Includes methods for creating and traversing linked list
  #
  class LinkedList
    # Include Module
    #
    include LinkedList::LinkedListSupport

    # Attribute Accessor
    #
    attr_accessor :head

    # Initialize
    #
    def initialize
      @head = LinkedList::Node.new
    end

    # Public Interface
    #
    # Add a node
    # @param value [String]
    # @return [Node]
    #
    def add_node(value)
      add_node_support(value)
    end

    # Print list value
    # @return [String]
    #
    def print_list
      print_list_support
    end

    # Traverse list
    # @return [Array]
    #
    def traverse
      traverse_support
    end
  end
end