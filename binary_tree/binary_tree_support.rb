require_relative '../stack/stack'
require_relative '../binary_tree/node'
# Used for namespacing
#
module BinaryTree
  # Includes support methods for BinaryTree
  #
  module BinaryTreeSupport
    # Constant to Hold Message
    #
    EMPTY_TREE_MSG = 'Binary Tree is empty'
    NEW_LEVEL_QUALIFIER = '*'

    # All methods in the module declared as private
    #
    private

    # Prints Nodes of a tree level wise
    # @param node [Node]
    # @return [NIL]
    #
    def display_support(node)
      print EMPTY_TREE_MSG and return if node.nil?
      stack = Stack::Stack.new
      stack.push(node)
      begin
        node = stack.pop
        print_val_new_line(node)
        push_node_on_stack(node, stack) unless node == NEW_LEVEL_QUALIFIER
      end until stack.empty?
      nil
    end

    # Push On stack depending upon node's left and right pointers
    # @param node [Node]
    # @param stack [Stack]
    # @return [NIL]
    #
    def push_node_on_stack(node, stack)
      return if node.nil? || (node.left.nil? && node.right.nil?)
      stack.push(node.right) unless node.right.nil?
      stack.push(node.left) unless  node.left.nil?
      stack.push(NEW_LEVEL_QUALIFIER)
    end

    # Prints a new line or a node value by inspecting content popped
    # @param node_or_val [Object]
    # @return [NIL]
    #
    def print_val_new_line(node_or_val)
      return if node_or_val.nil?
      return puts if node_or_val.is_a?(String) && node_or_val == NEW_LEVEL_QUALIFIER
      print node_or_val.value.to_s + '  '
    end

    # Calculates the in-order successor of a given node in a BST
    # @param node [Node]
    # @return [Node]
    #
    def prep_in_order_successor(node)
      return tree_minimum(node.right) unless node.right.nil?
      # If node's right subtree is nil, then we try to find the lowest ancestor greater than
      # node, this constitutes the in-order successor
      #
      y, x = node.parent, node
      until y.nil? || x == y.left
        x = y
        y = y.parent
      end
      y
    end

    # Delete a node
    # @param node [Node]
    # @return [NIL]
    #
    def delete_node_support(node)
      free_node_flag = true
      return transplant(node, node.right, free_node_flag) if node.left.nil?
      return transplant(node, node.left, free_node_flag) if node.right.nil?
      y = tree_minimum(node.right)
      unless y.parent == node
        transplant(y, y.right)
        y.right = node.right
        y.right.parent = y
      end
      transplant(node, y)
      y.left = node.left
      y.left.parent = y
      return free_node(node) if free_node_flag
      node
    end

    # Routine to transplant subtree rooted at node u to node v. Replaces
    # parent of u to have v as child instead of u. Assigns parent of v if it
    # is not NIL. Takes into account use case where v can be NIL
    # @param u [Node]
    # @param v [Node]
    # @return [NIL]
    #
    def transplant(u,v, free_node_flag = false)
      return assign_root_free_node(u, v, free_node_flag) if u.parent.nil?
      u.parent.left = v if u.parent.left == u
      u.parent.right = v if u.parent.right == u
      v.parent = u.parent unless v.nil?
      free_node(u) if free_node_flag
    end

    # Assigns root and frees node
    # @param u [Node]
    # @param v [Node]
    # @return [NIL]
    #
    def assign_root_free_node(u, v, free_node_flag)
      self.root  = v
      free_node(u) if free_node_flag
    end

    # Frees a given node  by assigning all its pointers to NIL
    # @param u [Node]
    # @return [NIL]
    #
    def free_node(u)
      [u.parent, u.left, u.right].each { |x| x = nil }
      u
    end

    # Inserts a given node in the tree
    # @param node [Node]
    # @return [Node]
    #
    def insert_node(node)
      y = nil
      x = self.root
      until x.nil? do
        y = x
        x = compare_and_compute_node(node, x)
      end
      node.parent = y
      # Before assigning root, parent must be set because parent of root is NIL
      #
      return self.root = node if y.nil?
      return y.left = node if node.value < y.value
      y.right = node
    end

    # Computes Tree Minimum for a subtree rooted at given node
    # @param node [Node]
    # @return [Node]
    #
    def tree_minimum_support(node)
      y = node
      until y.left.nil? do
        y = y.left
      end
      y
    end

    # Computes tree maximum for a subtree rooted at given node
    # @param node [Node]
    # @return [Node]
    #
    def tree_maximum_support(node)
      y = node
      until y.right.nil? do
        y = y.right
      end
      y
    end

    # Compute Node value after comparison
    # @param node [Node]
    # @param x [Node]
    # @return [Node]
    #
    def compare_and_compute_node(node, x)
      return x.left if node.value < x.value
      x.right
    end

    # Traverses tree recursively to return parent node and node to insert
    # @param node [Node]
    # @return [Node]
    #
    def recursive_search(node, x)
      return x if x.nil? || x.value == node.value
      x = compare_and_compute_node(node, x)
      recursive_search(node, x)
    end

    # Traverses tree non-recursively to return parent node and node to insert
    # @param node [Node]
    # @return [Node]
    #
    def iterative_search(node)
      x = self.root
      until x.nil? || x.value == node.value do
        x = compare_and_compute_node(node, x)
      end
      x
    end
  end
end