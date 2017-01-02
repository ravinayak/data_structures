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
      node = Node.new(value)
      list_value_node = traverse_support
      raise INTERNAL_ERROR if list_value_node[:last_node].nil?

      list_value_node[:last_node].next_node = node
    end

    # Remove a node
    # @param value [String]
    # @return [Node]
    #
    def remove_node_support(value)
      met_resp = find_node(value)
      return met_resp if met_resp[:node].nil?

      curr_node, prev_node = met_resp[:curr_node], met_resp[:prev_node]
      prev_node.next_node = curr_node.next_node
      curr_node = nil
    end

    # Find a node
    # @param value [String]
    # @return [Node]
    #
    def find_node(value)
      met_resp = analyze_head_support
      return met_resp if met_resp[:node].nil?

      curr_node, prev_node = self.head.next_node, self.head
      until curr_node.nil? || curr_node.value == value
        prev_node = curr_node
        curr_node = curr_node.next_node
      end

      { curr_node: curr_node, prev_node: prev_node, node: self.head }
    end

    # Print list value
    # @return [String]
    #
    def print_list_support
      list_value_node = traverse_support
      return print EMPTY_LIST if list_value_node[:list_value].nil?

      print list_value_node[:list_value]
    end

    # Traverse list
    # @return [Array]
    #
    def traverse_support
      met_resp = analyze_head_support
      return met_resp if met_resp[:node].nil?

      value_str, node = '', self.head
      curr_node, prev_node = node.next_node, node
      until curr_node.nil?
        value_str = (value_str + '   ' + curr_node.value.to_s)
        prev_node = curr_node
        curr_node = curr_node.next_node
      end

      { list_value: value_str, last_node: prev_node }
    end

    # Analyze head of list
    # @return [Hash]
    #
    def analyze_head_support
      node = self.head
      { list_value: nil, last_node: nil, node: node }
    end
  end
end