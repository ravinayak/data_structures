require_relative '../binary_tree_leetcode/binary_tree_lca'
require_relative '../binary_tree_leetcode/binary_tree_recover_binary_tree'
require_relative '../binary_tree_leetcode/binary_tree_prepare_bst'
# Used for namespacing
#
module BinaryTree
  module BinaryTreeLeetcode
    include BinaryTreeLca
    include BinaryTreeRecoverBinaryTree
    include BinaryTreePrepareBst
  end
end
