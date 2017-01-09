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

    # Returns maximum depth of a binary tree
    # @return [Integer]
    #
    def depth
      depth_support(self.root)
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

    # Creates a new tree that mirrors the original tree
    # @return [Node]
    #
    def create_mirror_tree
      node = ::BinaryTree::Node.new
      create_mirror_tree_support(self.root, node)
      display_support(node)
    end

    # Mirrors the original tree
    # @return [Node]
    #
    def mirror_tree
      mirror_tree_support(self.root)
      display_support(self.root)
    end

    # Doubles tree
    # @return [Node]
    #
    def create_double_tree
      node = ::BinaryTree::Node.new
      create_double_tree_support(self.root, node)
      display_support(node)
    end

    # Private Methods
    #
    private

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

    # Support method for determining size of a tree
    # @param node [Node]
    # @return [Integer]
    #
    def size_support(node)
      return 0 if node.nil?
      size_support(node.left) + 1 + size_support(node.right)
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

    # Support method to mirror tree
    # @param node [Node]
    # @return [Node]
    #
    def mirror_tree_support(node)
      return if node.nil?
      tmp = node.left
      node.left = node.right
      node.right = tmp
      mirror_tree_support(node.left)
      mirror_tree_support(node.right)
    end

    # Support method to create mirror tree
    # @param original_node [Node]
    # @param mirror_node [Node]
    # @return [Node]
    #
    def create_mirror_tree_support(original_node, mirror_node)
      return if original_node.nil? || mirror_node.nil?
      mirror_node.value = original_node.value
      mirror_node.left = ::BinaryTree::Node.new unless original_node.right.nil?
      mirror_node.right = ::BinaryTree::Node.new unless  original_node.left.nil?
      create_mirror_tree_support(original_node.right, mirror_node.left)
      create_mirror_tree_support(original_node.left, mirror_node.right)
    end

    # Double Tree Support Method
    # @param original_node [Node]
    # @param double_tree_node [Node]
    # @return [Node]
    #
    def create_double_tree_support(original_node, double_tree_node)
      return if original_node.nil? || double_tree_node.nil?
      double_tree_node.value = original_node.value
      node = ::BinaryTree::Node.new
      node.value = original_node.value
      double_tree_node.left = node
      node.left = ::BinaryTree::Node.new unless original_node.left.nil?
      double_tree_node.right = ::BinaryTree::Node.new unless original_node.right.nil?
      create_double_tree_support(original_node.left, node.left)
      create_double_tree_support(original_node.right, double_tree_node.right)
    end
  end
end