# Used for namespacing
#
module DoublyLinkedList
  # Class definition
  #
  class Node
    # Attribute Accessor
    #
    attr_accessor :next_node, :prev_node, :value

    # Initialize
    #
    def initialize(value = nil, next_node = nil, prev_node = nil)
      @value = value
      @next_node = next_node
      @prev_node = prev_node
    end
  end
end