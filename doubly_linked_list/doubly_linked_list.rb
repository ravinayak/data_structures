require_relative '../doubly_linked_list/node'
require_relative '../list_methods'
# Used for namespacing
#
module DoublyLinkedList
  # Class definition
  #
  class DoublyLinkedList
    # Includes module
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

    # Adds a node
    # @param value [String]
    # @return [Node]
    #
    def add_node(value)
      add_node_support(value, :doubly_linked_list)
    end

    # Removes a node
    # @param value [String]
    # @return [Node]
    #
    def remove_node(value)
      remove_node_support(value)
    end

    # Traverses list
    # @return [NIL]
    #
    def traverse
      traverse_support
    end

    # Prints List
    #
    def print_list
      print_list_support
    end

    # Finds a Node for a given value
    # @param value [String]
    # @return [Node]
    #
    def find_node(value)
      met_resp = find_node_support(value)
      return nil if met_resp[:node].nil?

      met_resp[:node]
    end
  end
end