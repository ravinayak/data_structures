# Used for namespacing
#
module BinaryTree
  # Includes solutions for binary tree problems
  #
  module BinaryTreeProblems
    # Counts the number of nodes in the tree
    # @return [Integer]
    #
    def size
      size_support(self.root)
    end

    # Support method for determining size of a tree
    # @param node [Node]
    # @return [Integer]
    #
    def size_support(node)
      return 0 if node.nil?
      size_support(node.left) + 1 + size_support(node.right)
    end

    # Returns maximum depth of a binary tree
    # @return [Integer]
    #
    def depth
      depth_support(self.root)
    end

    # Finds the maximum depth of a tree
    # @param node [Node]
    # @return [Integer]
    #
    def depth_support(node)
      return 0 if node.nil?
      l_depth = depth_support(node.left)
      r_depth = depth_support(node.right)
      [l_depth, r_depth].max + 1
    end

    # Returns true if there exists a path in the tree from root to leaf which
    # adds up to the given sum
    # @param node [Node]
    # @param sum [Integer]
    # @return [TrueClass/FalseClass]
    #
    def has_path_sum(node, sum)
      return false if node.nil?
      sub_sum = sum - node.value
      return true if sub_sum == 0 && node.left.nil? && node.right.nil?
      has_path_sum(node.left, sub_sum) || has_path_sum(node.right, sub_sum)
    end

    # Prints all the paths from the root to the leaf node in a tree
    # @return [NIL]
    #
    def print_paths
      path, counter = [], 0
      puts '************************ Tree Paths ***********************************'
      puts
      print_tree_paths(self.root, path, counter)
      puts
      puts '***********************************************************************'
    end

    # Helper method to prints paths in a tree
    # @param node [Node]
    # @param path [Array]
    # @param counter [Integer]
    # @return [NIL]
    #
    def print_tree_paths(node, path, counter)
      return if node.nil?
      path[counter] = node
      counter += 1
      return print_nodes(path, counter) if node.left.nil? && node.right.nil?
      print_tree_paths(node.left, path, counter) unless node.left.nil?
      print_tree_paths(node.right, path, counter) unless node.right.nil?
    end

    # Helper method to print the paths in an array
    # @param path [Array]
    # @param counter [Integer]
    # @return [NIL]
    #
    def print_nodes(path, counter)
      (0..(counter - 1)).each { |i| print path[i].value.to_s + '  ' }
      puts
    end
  end
end