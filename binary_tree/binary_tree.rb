require_relative '../binary_tree/binary_tree_support'

# Used for namespacing
#
module BinaryTree
  # Class definition
  #
  class BinaryTree
    # Include module
    #
    include BinaryTreeSupport

    # Attribute Accessors
    #
    attr_accessor :root

    # Initialize node
    #
    def initialize(root = nil)
      @root = root
    end

    # Add a node
    # @param value [String]
    # @return [Node]
    #
    def add_node(value)
      insert_node(prep_node(value))
    end

    # Delete a node
    # @param value [String]
    # @return [Node]
    #
    def delete_node(value)
      delete_node_support(prep_node(value))
    end

    # Returns Tree Minimum
    # @param value [String]
    # @return [Node]
    #
    def tree_minimum(value)
      tree_minimum_support(prep_node(value))
    end

    # Returns Tree Minimum
    # @param value [String]
    # @return [Node]
    #
    def tree_maximum(value)
      tree_maximum_support(prep_node(value))
    end

    # Search a value
    # @param value [String]
    # @param method_type [Symbol]
    # @return [Node]
    #
    def search(value, method_type = :iterative)
      case method_type
      when :recursive
        return recursive_search(prep_node(value), self.root)
      when :iterative
        return iterative_search(prep_node(value))
      else
        return nil
      end
    end

    # Compute in-order successor of a value
    # @param value [String]
    # @return [Node]
    #
    def in_order_successor(value)
      prep_in_order_successor(prep_node(value))
    end

    # Displays nodes of a tree level wise
    # @return [NIL]
    #
    def display
      display_support(self.root)
    end

    # Prepares node from a given value
    # @param val [String]
    # @return [Node]
    #
    def prep_node(val)
      node = BinaryTree::Node.new
      node.value = val
      node
    end
  end
end
