require_relative '../binary_tree/binary_tree_support'
require_relative '../binary_tree/binary_tree_stanford_problems'
require_relative '../binary_tree/binary_tree_leetcode/binary_tree_leetcode'
require_relative '../binary_tree/binary_tree_geeks_for_geeks/binary_tree_geeks_for_geeks'

# Used for namespacing
#
module BinaryTree
  # Class definition
  #
  class BinaryTree
    # Include module
    #
    include BinaryTreeSupport
    include BinaryTreeStanfordProblems
    include BinaryTreeLeetcode
    include BinaryTreeGeeksForGeeks

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
      node = search(value)
      return nil if node.nil?
      delete_node_support(node)
    end

    # Returns Tree Minimum
    # @param node_or_value [Object]
    # @return [Node]
    #
    def tree_minimum(node_or_value)
      node = prep_node_for_input(node_or_value)
      return nil if node.nil?
      tree_minimum_support(node)
    end

    # Returns Tree Minimum
    # @param value [String]
    # @return [Node]
    #
    def tree_maximum(value)
      node = search(value)
      return nil if node.nil?
      tree_maximum_support(node)
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
      node = search(value)
      return nil if node.nil?
      prep_in_order_successor(node)
    end

    # Compute in-order prdecessor of a value
    # @param value [String]
    # @return [Node]
    #
    def in_order_predecessor(value)
	    node = search(value)
	    return nil if node.nil?
	    prep_in_order_predecessor(node)
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
      node = Node.new
      node.value = val
      node
    end
  end
end

# To run and create binary tree
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/binary_tree/binary_tree'
# bt = BinaryTree::BinaryTree.new
# [25, 18, 45, 13, 22, 35, 55, 9, 16, 20, 24, 30, 40, 50, 60, 1, 75].each do |val|
#   bt.add_node(val)
# end
#
# 25
# 18							   45
# 13				22     			 35	            55
# 9           16      20      24       30       40      50      60
# 1											                       75

