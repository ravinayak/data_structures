# Used for namespacing
#
module BinaryTree
  # Used for namespacing
  #
  module BinaryTreeLeetcode
    # Includes methods for recovering a binary tree
    #
    module BinaryTreeRecoverBinaryTree
      # This file includes problems and solutions from Leetcode
      #
      MAX_VALUE = (2 ** ((0.size * 8) - 2) - 1)
      MIN_VALUE = -(2 ** ((0.size * 8) - 2))

      # 0.size => This gives the number of bytes in the machine representation of 0
      # ['foo'].pack('p').size =>
      #       ['foo'].pack('p')       =>  This gives the number of bytes required for machine representation of pointer
      #                                   for null terminated string of 'foo'
      #       ['foo'].pack('p').size  => This gives the number of bytes in machine representation of pointer
      #
      # Ruby reserves 2 bits  =>  1 bit for determining whether an integer or a pointer
      #                       =>  1 bit for determining sign
      #                       =>  This leaves 2 bits out for positive integers

      # For negative integers, 1 bit is used which was reserved for sign, using TWO's complement we can represent negative
      # numbers. For example,
      # for 4 bits, a number +7 when turned negative would be
      #     Step 1. Represent positive number in bits, [ +7  =>  0111  ]
      #     Step 2. Convert 1's to 0's, [ -7 => 0111 => 1000  ]
      #     Step 3. Add 1 to converted number, [  -7 => 0111 => 1000  => (add 1) => 1001 => -7  ]
      #     Step 4. Result of Step 3 is negative number representation in bits
      #
      # For 4 bits, if 1 bit is reserved, maximum positive number is 7 [  2 ** (4-1) - 1  ], for n bits => [  ((2 ** (n-1)) - 1) ]
      # For 4 bits, if 1 bit is reserved, maximum negative number is -8 [ 2 ** (4-1) ], for n bits => [ ((2 ** (n-1)))  ]
      #       +8 when turned negative is, [ +8  => 1000 => 0111 =>  Add 1 to it =>  1000  => -8 ]
      #       so for 4 bits the range is  [ -8 => +7  ]
      #
      # Normally if a bit is not reserved, then for n bits
      #   Range of unsigned integers is [ 0 to ((2 **  n) - 1) ], for example
      #         For 4 bits, range would be [  0 to 15  ]
      #   Range of signed integer is  [ -((2 ** (n-1))) to +((2 ** (n-1)) - 1) ]
      #         For 4 bits, range would be [  -8 to +7  ]
      #
      #
      # This method recovers a binary tree by swapping two incorrect nodes
      #
      def recover_binary_tree
        node_arr = []
        find_swapped_nodes_support(self.root, MIN_VALUE, MAX_VALUE, node_arr)
        recover_swapped_value(node_arr)
      end

      private

      def find_swapped_nodes_support(node, min_value, max_value, node_arr)
        return if node.nil?
        node_value_incremented = node.value + 1
        find_swapped_nodes_support(node.left, min_value, node.value, node_arr)
        is_valid_bst(node.left, min_value, node.value, :left, node_arr)
        find_swapped_nodes_support(node.right, node_value_incremented, max_value, node_arr)
        is_valid_bst(node.right, node_value_incremented, max_value, :right, node_arr)
        node_arr
      end

      def is_valid_bst(node, min_value, max_value, left_or_right, node_arr)
        return if node.nil?
        case left_or_right
          # This left or right split is essential to preserve the structure of binary tree that
          # all nodes less than or equal to parent go to left and only nodes greater than current node
          # go to right
          # This leads to a small bug that max value cannot be allocated to any node in the binary tree
          #
          # Run the algorithm for following binary tree
          #               100
          #         90              110
          #   80        95    105         115
          #                                     120
          #
        when :left
          return true if node.value >= min_value && node.value <= max_value
        when :right
          return true if node.value >= min_value && node.value < max_value
        else
          node_arr << node # This use case should never be reached
        end
        node_arr << node
      end

      def recover_swapped_value(node_arr)
        tmp               = node_arr[0].value
        node_arr[0].value = node_arr[1].value
        node_arr[1].value = tmp
      end
    end
  end
end
