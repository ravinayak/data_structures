require_relative '../stack/stack'

# Used for namespacing
#
module BinaryTree
  # Class definition
  #
  class BinaryTree

    # Attribute Accessors
    #
    attr_accessor :root

    # Initialize node
    #
    def initialize(root)
      @root = root
    end

    # Add a node
    # @param node [Node]
    # @return [Node]
    #
    def add_node(node)
      insert_node(node)
    end

    # Delete a node
    # @param node [Node]
    # @return [Node]
    #
    def delete_node(node)
      delete_node_support(node)
    end

    # Returns Tree Minimum
    # @param node [Node]
    # @return [Node]
    #
    def tree_minimum(node)
      tree_minimum_support(node)
    end

    # Returns Tree Minimum
    # @param node [Node]
    # @return [Node]
    #
    def tree_maximum(node)
      tree_maximum_support(node)
    end

    # Search a node
    # @param node [Node]
    # @param method_type [Symbol]
    # @return [Node]
    #
    def search(node, method_type)
      case method_type
      when :recursive
        return recursive_search(node, self.root)
      when :iterative
        return iterative_search(node)
      else
        return nil
      end
    end

    # Compute in-order successor of a node
    # @param node [Node]
    # @return [Node]
    #
    def in_order_successor(node)
      prep_in_order_successor(node)
    end

    # Displays nodes of a tree level wise
    # @return [NIL]
    #
    def display
      display_support(self.root)
    end
  end
end
