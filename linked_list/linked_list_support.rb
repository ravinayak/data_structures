# Used for namespacing
#
module LinkedList
  # Includes methods for linked list methods
  #
  module LinkedListSupport
    # Constant to hold string values
    #
    EMPTY_LIST = 'Empty List'
    INTERNAL_ERROR = 'Internal Error'

    # Private Methods
    #
    private

    # Add a node
    # @param value [String]
    # @return [Node]
    #
    def add_node_support(value)
      node = Node::Node.new(value)
      list_value_node = traverse
      raise INTERNAL_ERROR if list_value_node[:last_node].nil?

      list_value_node[:last_node].next_node = node
    end

    # Print list value
    # @return [String]
    #
    def print_list_support
      list_value_node = traverse
      return print EMPTY_LIST if list_value_node[:list_value].nil?

      print list_value_node[:list_value]
    end

    # Traverse list
    # @return [Array]
    #
    def traverse_support
      node = self.head
      value_str = ''
      return { list_value: nil, last_node: nil } if node.nil?

      curr_node, prev_node = node.next_node, node
      until curr_node.nil?
        value_str = (value_str + '   ' + curr_node.value.to_s)
        prev_node = curr_node
        curr_node = curr_node.next_node
      end

      { list_value: value_str, last_node: prev_node }
    end
  end
end