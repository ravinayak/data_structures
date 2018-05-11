# Used for namespacing
#
module BinaryTree
  # Includes methods for solving problems from GeeksforGeeks
  #
  module BinaryTreeGeeksForGeeks
    # Used for namespacing
    #
    module BinaryTreeDiameter
      # Class to maintain value of Height of a node
      #
      class Height
        # Attribute Accessor
        #
        attr_accessor :ht
        # Initialize Height Objects with provided value
        #
        def initialize(ht: 0)
          @ht = ht
        end
      end
      
      # Calculates diameter of a tree in less optimized way
      # Diameter of a tree is defined as the maximum of the following -
      #   1. Left Diameter of Root
      #   2. Right Diameter of Root
      #   3. Left Height of Root + Right Height of Root + 1 (Number of nodes on the longest path from root to left
      #                                                      and right including root)
      # This definition is recursive in nature and applies to Root which is a node, same can be applied to all nodes
      # However, this means we shall have to evaluate height more than once for a node. At a minimum this will recurse
      # over all the nodes twice which is same as O(n) but higher by a constant factor
      #
      # @param optimized [Boolean]
      # @return [Integer]
      #
      def calculate_diameter(optimized: true)
        return 0 if self.root.nil?
        return calculate_diameter_unoptimized(self.root) unless optimized
        height = Height.new
        calculate_diameter_optimized(self.root, height)
      end
      
      # @param node [Node]
      # @return [Integer]
      #
      def calculate_diameter_unoptimized(node)
        return 0 if node.nil?
        left_ht = depth_support(node.left)
        right_ht = depth_support(node.right)
        diameter_left = calculate_diameter_unoptimized(node.left)
        diameter_right = calculate_diameter_unoptimized(node.right)
        [diameter_left, diameter_right, (left_ht + right_ht + 1)].max
      end
      
      # Evaluates diameter while evaluating height of node in the same recursive call. This method passes height
      # object to lower recursive calls, and evaluates height by taking Max of Left Height, Right Height and adding
      # 1 for the node whose height is to be calculated
      # Once height is evaluated, diameter to be returned from the node is calculated
      # This ensures we look at every node in the BST only once.
      #
      # @param node [Node]
      # @param height [Height]
      # @return [Integer]
      #
      def calculate_diameter_optimized(node, height)
        return prep_diam_for_nil_node(height) if node.nil?
        
        left_ht = Height.new
        diam_left = calculate_diameter_optimized(node.left, left_ht)
        right_ht = Height.new
        diam_right = calculate_diameter_optimized(node.right, right_ht)
        
        height.ht = ([left_ht.ht, right_ht.ht].max) + 1 # This calculates height of the given node
        
        # left_ht.ht + right_ht.ht + 1 => Adds max nodes on left, max nodes on right and includes node in question
        #
        [diam_left, diam_right, (left_ht.ht + right_ht.ht + 1)].max
      end
      
      # @param height [Height]
      # @return [Integer]
      #
      def prep_diam_for_nil_node(height)
        height.ht = 0
        0
      end
    end
  end
end

# To run and create binary tree
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/binary_tree/binary_tree'
# bt = BinaryTree::BinaryTree.new
# [980, 950, 800, 100, 300, 200, 700, 600, 650, 825, 880, 870, 850, 860, 985, 990].each do |val|
#   bt.add_node(val)
# end

# 980
# 950   985
# 800   990
# 100   825
# 300   880
# 200   700   870
# 600   850
# 650   860
#
# bt.calculate_diameter(optimized: false)
# bt.calculate_diameter(optimized: true)