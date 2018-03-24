require_relative '../binary_tree_leetcode/binary_tree_lca'
require_relative '../binary_tree_leetcode/binary_tree_recover_binary_tree'
require_relative '../binary_tree_leetcode/binary_tree_prepare_bst'
require_relative '../binary_tree_leetcode/binary_tree_find_nth_smallest_largest'
# Used for namespacing
#
module BinaryTree
  module BinaryTreeLeetcode
    include BinaryTreeLca
    include BinaryTreeRecoverBinaryTree
    include BinaryTreePrepareBst
    include BinaryTreeFindNthSmallestLargest
  end
end
