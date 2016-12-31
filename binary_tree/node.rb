# Used for namespacing
#
module BinaryTree
  # Class Definition for Node
  #
  class Node
    # Attribute Accessors
    #
    attr_accessor :left_node, :right, :parent, :value

    # Initialize node
    #
    def initialize(left = nil, right = nil, parent = nil, value = nil)
      @left = left
      @right = right
      @parent = parent
      @value = value
    end
  end
end
