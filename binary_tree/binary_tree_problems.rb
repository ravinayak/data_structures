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
  end
end