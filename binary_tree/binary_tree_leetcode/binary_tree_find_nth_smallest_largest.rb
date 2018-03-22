# Used for namespacing
#
module BinaryTree
  # Includes methods for finding nth smallest, largest elements
  #
  module BinaryTreeFindNthSmallestLargest
    
    # @note
    # Finding nth smallest and nth largest elements in a Binary Search Tree
    # can be approached in various ways -
    #   1.  In-Order Traversal with stack => This approach requires us to do an in-order
    #       traversal and maintain count variable to keep count of nth smallest element.
    #       In-Order traversal is performed using Stack
    #   2.  In-Order Traversal with O(1) storage space (Morris Traversal) => This approach
    #       does not need any extra storage space and uses threading concepts to traverse a
    #       tree in-order. We maintain count variable to keep count of nth smallest element.
    #       To find nth largest element, we do a reverse in-order traversal and keep count.
    #   3.  Augmenting BST => We augment BST such that it includes information about count
    #       of nodes. This count can be used to find nth smallest/largest elements. It can
    #       be used to answer Range Media Queries
    #
  end
end