require_relative '../binary_tree_leetcode/binary_tree_lca'
require_relative '../binary_tree_leetcode/binary_tree_recover_binary_tree'
# Used for namespacing
#
module BinaryTree
  module BinaryTreeLeetcode
    include BinaryTreeLca
    include BinaryTreeRecoverBinaryTree
  end
end
