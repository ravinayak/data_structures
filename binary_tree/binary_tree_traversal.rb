# Used for namespacing
#
module BinaryTree
  # Includes methods for traversal of tree
  #
  module BinaryTreeTraversal
    # Includes pre-order traversal method
    #
    def rec_pre_order(root)
      return nil if root.nil?
      print root.value.to_s + '  '
      rec_pre_order(root.left)
      rec_pre_order(root.right)
    end

    # Includes post-order traversal method
    #
    def rec_post_order(root)
      return nil if root.nil?
      rec_post_order(root.left)
      rec_post_order(root.right)
      print root.value.to_s + '  '
    end

    # Includes in-order traversal method
    #
    def rec_in_order(root)
      return nil if root.nil?
      rec_in_order(root.left)
      print root.value.to_s + '  '
      rec_in_order(root.right)
    end

    # Includes pre-order iterative method
    #
    def ite_pre_order(root)
      return nil if root.nil?
      stack = Stack::Stack.new
      stack.push(root)
      begin
        node = stack.pop
        print node.value.to_s + '  '
        stack.push(node.right) unless node.right.nil?
        stack.push(node.left) unless node.left.nil?
      end until stack.empty?
    end

    # Includes post-order iterative method
    #
    def ite_post_order(root)
      return nil if root.nil?
      stack_traverse = Stack::Stack.new
      stack_print = Stack::Stack.new
      stack_traverse.push(root)
      begin
        node = stack_traverse.pop
        stack_traverse.push(node.left) unless node.left.nil?
        stack_traverse.push(node.right) unless node.right.nil?
        stack_print.push(node)
      end until stack_traverse.empty?

      begin
        node = stack_print.pop
        print node.value.to_s + '  '
      end until stack_print.empty?
      nil
    end

    # Includes in-order iterative method
    #
    def ite_in_order(root)
      return nil if root.nil?
      stack = Stack::Stack.new
      node = root
      begin
        until node.nil?
          stack.push(node)
          node = node.left
        end
        node = stack.pop
        print node.value.to_s + '  '
        node = node.right
      end until stack.empty? && node.nil?
    end
  end
end