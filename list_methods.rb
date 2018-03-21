# Includes methods for list traversal
#
module ListMethods
  # Constant to hold string values
  #
  EMPTY_LIST = 'Empty List'
  INTERNAL_ERROR = 'Internal Error'
  NODE_NOT_FOUND = 'Node was not found'

  # Private Methods
  #
  private

  # Add a node
  # @param value [String]
  # @return [Node]
  #
  def add_node_support(value, list_type_sym)
    node = node_class(list_type_sym).new(value)
    list_value_node = traverse_support
    raise INTERNAL_ERROR if list_value_node[:last_node].nil?

    list_value_node[:last_node].next_node = node
    node.prev_node = list_value_node[:last_node] if node.respond_to?(:prev_node) && node.prev_node.nil?
  end

  # Returns node depending upon type of list
  # @param list_type_sym [Symbol]
  # @return [Object]
  #
  def node_class(list_type_sym)
    case list_type_sym
    when :linked_list
      ::LinkedList::Node
    when :doubly_linked_list
      ::DoublyLinkedList::Node
    else
      nil
    end
  end

  # Remove a node
  # @param value [String]
  # @return [Node]
  #
  def remove_node_support(value)
    met_resp = find_node_support(value)
    return NODE_NOT_FOUND if met_resp[:node].nil?

    curr_node, prev_node = met_resp[:curr_node], met_resp[:prev_node]
    prev_node.next_node = curr_node.next_node
    curr_node.prev_node = prev_node if curr_node.respond_to?(:prev_node) && !curr_node.prev_node.nil?
    curr_node
  end

  # Find a node
  # @param value [String]
  # @return [Node]
  #
  def find_node_support(value)
    met_resp = analyze_head_support
    return met_resp if met_resp[:node].nil?

    curr_node, prev_node = self.head.next_node, self.head
    until curr_node.nil? || curr_node.value == value
      prev_node = curr_node
      curr_node = curr_node.next_node
    end

    { curr_node: curr_node, prev_node: prev_node, node: curr_node }
  end

  # Find a node given node number
  # @param node_num [Integer]
  # @return [Node]
  #
  def value_given_node_no_support(node_num)
    met_resp = analyze_head_support
    return nil if met_resp[:node].nil?

    node, counter = self.head.next_node, 1
    until node.nil? || counter == node_num
      counter += 1
      node = node.next_node
    end

    node
  end

  # Print list value
  # @return [String]
  #
  def print_list_support
    list_value_node = traverse_support
    return print EMPTY_LIST if list_value_node[:list_value].nil?

    print list_value_node[:list_value]
  end

  # Determine Length of Linked List
  # @return [Integer]
  #
  def determine_length_support
    met_resp = analyze_head_support
    return 0 if met_resp[:node].nil?

    # Head is a dummy node, so there is one extra node than the values added to
    # the list
    #
    node, length = self.head.next_node, 0
    until node.nil?
      length += 1
      node = node.next_node
    end

    length
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
