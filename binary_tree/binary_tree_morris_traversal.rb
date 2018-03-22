# Used for namespacing
#
module BinaryTree
  # Includes methods for Morris Traversal
  #
  module BinaryTreeMorrisTraversal
  
    # In-Order Traversal
    # @param root [Node]
    # @return [NIL]
    #
    def in_order_morris_traversal(root)
      return nil if root.nil?
      current, predecessor_store = root, { }
      until current.nil?
        if current.left.nil?
          print current.value.to_s + ' '
          current = current.right
        else
          predecessor = prepare_store_predecessor(current, predecessor_store)
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
      nil
    end
    
    # Pre-Order Traversal
    # @param root [Node]
    # @return [NIL]
    #
    def pre_order_morris_traversal(root)
      return nil if root.nil?
      current, predecessor_store = root, { }
      until current.nil?
        if current.left.nil?
          print current.value.to_s + ' '
          current = current.right
        else
          predecessor = prepare_store_predecessor(current, predecessor_store)
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
      nil
    end
    
    # Post-Order Traversal
    # @param root [Node]
    # @return [NIL]
    #
    def post_order_morris_traversal(root)
      return nil if root.nil?
      temp = Node.new
      temp.left = root
      current, res_arr, predecessor_store = temp, [], { }
      until current.nil?
        if current.left.nil?
          current = current.right
        else
          predecessor = prepare_store_predecessor(current, predecessor_store)
          if predecessor.right.nil?
            predecessor.right = current
            current = current.left
          else
            predecessor.right = nil
            res_arr << current_left_to_predecessor(current, predecessor)
            current = current.right
          end
        end
      end
      res_arr.flatten.each { |node_value| print node_value.to_s + ' '}
      nil
    end
    
    # Finds Predecessor of a node in store if it exists, else computes it and stores it in store
    # @param node [Node]
    # @param predecessor_store [Hash]
    # @return [Node]
    #
    def prepare_store_predecessor(node, predecessor_store)
      return predecessor_store[node.object_id] unless predecessor_store[node.object_id].nil?
      predecessor_store[node.object_id] = prep_in_order_predecessor(node)
    end
  end
end