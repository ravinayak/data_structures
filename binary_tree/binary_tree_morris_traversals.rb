# Used for namespacing
#
module BinaryTree
	# Includes Morris Order Traversals
	#
	module BinaryTreeMorrisTraversals
		# In-Order Traversal
		# @param root [Node]
		# @return [NIL]
		#
		def in_order_morris_traversal(root)
			return nil if root.nil?
			current = root
			until current.nil?
				if current.left.nil?
					print current.value.to_s + ' '
					current = current.right
				else
					predecessor = in_order_predecessor(current)
					if predecessor.right.nil?
						predecessor.right = current
						current = current.left
					else
						predecessor.right = nil
						print current.value.to_s + ' '
						current = current.right
					end
				end
			end
		end
		
		# Pre-Order Traversal
		# @param root [Node]
		# @return [NIL]
		#
		def pre_order_morris_traversal(root)
			return nil if root.nil?
			current = root
			until current.nil?
				if current.left.nil?
					print current.value.to_s + ' '
					current = current.right
				else
					predecessor = in_order_predecessor(current)
					if predecessor.right.nil?
						predecessor.right = current
						print current.value.to_s + ' '
						current = current.left
					else
						predecessor.right = nil
						current = current.right
					end
				end
			end
		end
		
		# Post-Order Traversal
		# @param root [Node]
		# @return [NIL]
		#
		def post_order_morris_traversal(root)
			return nil if root.nil?
			temp = Node.new
			temp.left = root
			current = temp
			result_arr = []
			until current.nil?
				if current.left.nil?
					current = current.right
				else
					predecessor = in_order_predecessor(current)
					if predecessor.right.nil?
						predecessor.right = current
						current = current.left
					else
						predecessor.right = nil
						result_arr << current_left_to_predecessor(current, predecessor)
						current = current.right
					end
				end
			end
			result_arr.each {|node| print node.value.to_s + ' '}
			nil
		end
	end
end