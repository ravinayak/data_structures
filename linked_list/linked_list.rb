require_relative '../linked_list/node'
require_relative '../list_methods'

# Used for namespacing
#
module LinkedList
  # Includes methods for creating and traversing linked list
  #
  class LinkedList
    # Include Module
    #
    include ListMethods

    # Attribute Accessor
    #
    attr_accessor :head

    # Initialize
    #
    def initialize
      @head = Node.new
    end

    # Public Interface
    #
    # Add a node
    # @param value [String]
    # @return [Node]
    #
    def add_node(value)
      add_node_support(value, :linked_list)
    end

    # Remove a node
    # @param value [String]
    # @return [Node]
    #
    def remove_node(value)
      remove_node_support(value)
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

    # Determine length of list
    # @return [Integer]
    #
    def determine_length
      determine_length_support
    end

    # Finds a node for given value
    # @param value [String]
    # @return [Node]
    #
    def find_node(value)
      met_resp = find_node_support(value)
      return nil if met_resp[:node].nil?

      met_resp[:node]
    end

    # Find Value of a node when number of node is given
    # @param node_num [Integer]
    # @return [String]
    #
    def find_value_given_node_no(node_num)
      value_given_node_no_support(node_num)
    end
    # Code to create a list and add nodes to it
    # Print list
    #
    # require '/Users/ravinayak/projects/data_structures/linked_list/linked_list'
    # list = LinkedList::LinkedList.new
    # [89, 90, 14, 13, 15, 80, 45, 55, 65].each { |val| list.add_node(val) }
  end
end
