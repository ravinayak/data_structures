# Used for namespacing
#
module BinaryTree
  # Includes Recursive and Iterative methods for traversal of tree
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
      loop do
        node = stack.pop
        print node.value.to_s + '  '
        stack.push(node.right) unless node.right.nil?
        stack.push(node.left) unless node.left.nil?
        break if stack.empty?
      end
    end

    # Includes post-order iterative method
    #
    def ite_post_order(root)
      return nil if root.nil?
      stack_traverse = Stack::Stack.new
      stack_print = Stack::Stack.new
      stack_traverse.push(root)
      loop do
        node = stack_traverse.pop
        stack_traverse.push(node.left) unless node.left.nil?
        stack_traverse.push(node.right) unless node.right.nil?
        stack_print.push(node)
        break if stack_traverse.empty?
      end

      loop do
        node = stack_print.pop
        print node.value.to_s + '  '
        break if stack_print.empty?
      end
      nil
    end
    
    # Includes post-order iterative method which uses one stack
    #
    def ite_post_order_using_one_stack(root)
	    return nil if root.nil?
	    st = Stack::Stack.new
	    current = root
	    while !st.empty? || !current.nil?
				while !current.nil?
					st.push(current)
					current = current.left
				end
				temp = st.peek.right
				if temp.nil?
					temp = st.pop
					print temp.value.to_s + ' '
					while !st.empty? && temp == st.peek.right
						temp = st.pop
						print temp.value.to_s + ' '
					end
				else
					current = temp
				end
	    end
	    nil
    end

    # Includes in-order iterative method
    #
    def ite_in_order(root)
      return nil if root.nil?
      stack = Stack::Stack.new
      node = root
      loop do
        until node.nil?
          stack.push(node)
          node = node.left
        end
        node = stack.pop
        print node.value.to_s + '  '
        node = node.right
        break if stack.empty? && node.nil?
      end
    end
  end
end