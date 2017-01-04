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
  end
end