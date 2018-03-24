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
    #       In-Order traversal is performed using Stack.
    #           Time Complexity = O(n), where n = number of nodes
    #           Space Complexity = O(n), where n  = number of nodes
    #   2.  In-Order Traversal with O(1) storage space (Morris Traversal) => This approach
    #       does not need any extra storage space and uses threading concepts to traverse a
    #       tree in-order. We maintain count variable to keep count of nth smallest element.
    #       To find nth largest element, we do a reverse in-order traversal and keep count.
    #           Time Complexity = O(n), where n = number of nodes
    #           Space Complexity = O(1), to maintain count of nodes
    #   3.  Augmenting BST => We augment BST such that it includes information about count
    #       of nodes. This count can be used to find nth smallest/largest elements. It can
    #       be used to answer Range Media Queries
    #           Time Complexity = O(h), where h = height of BST
    #           Space Complexity = Augmented BST where rank is stored at each node
    #
    
    # Finds nth smallest element using in-order traversal.
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_smallest_using_in_order(root, n)
      node, count = root, 0
      st = Stack::Stack.new
      loop do
        until node.nil?
          st.push(node)
          node = node.left
        end
        node = st.pop
        count += 1
        puts "Nth Smallest Element :: #{node.value.to_s}" if count == n
        node = node.right
        break if st.empty? && node.nil?
      end
    end

    # Finds nth largest element using in-order traversal.
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_largest_using_in_order(root, n)
      node, count = root, 0
      st = Stack::Stack.new
      loop do
        until node.nil?
          st.push(node)
          node = node.right
        end
        node = st.pop
        count += 1
        puts "Nth Largest element :: #{node.value.to_s}" if count == n
        node = node.left
        break if st.empty? && node.nil?
      end
    end
    
    # Finds nth smallest element using extra storage space
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_smallest_using_augment(root, n)
      lr_count_store = { }
      augment_to_keep_node_counts(root, lr_count_store, :left_count)
      find_nth_smallest_element(root, n, lr_count_store)
    end

    # Finds nth largest element using extra storage space
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_largest_using_augment(root, n)
      lr_count_store = { }
      augment_to_keep_node_counts(root, lr_count_store, :right_count)
      find_nth_largest_element(root, n, lr_count_store)
    end
    
    # Finds nth smallest element using Morris Traversal
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_smallest_using_morris(root, n)
      return nil if n <= 0
      current, count, predecessor_store = root, 0, { }
      until current.nil?
        if current.left.nil?
          count = count + 1
          puts "n(#{n})th Smallest Element :: #{current.value.to_s}" if count == n
          current = current.right
        else
          predecessor = prepare_store_predecessor(current, predecessor_store)
          if predecessor.right.nil?
            predecessor.right = current
            current = current.left
          else
            predecessor.right = nil
            count = count + 1
            puts "n(#{n})th Smallest Element :: #{current.value.to_s}" if count == n
            current = current.right
          end
        end
      end
    end

    # Finds nth largest element using Morris Traversal
    # @param root [Node]
    # @param n [Numeric]
    # @return [Node]
    #
    def nth_largest_using_morris(root, n)
      return nil if n <= 0
      current, count, successor_store = root, 0, { }
      until current.nil?
        if current.right.nil?
          count = count + 1
          puts "n(#{n})th Smallest Element :: #{current.value.to_s}" if count == n
          current = current.left
        else
          successor = prepare_store_successor(current, successor_store)
          if successor.left.nil?
            successor.left = current
            current = current.right
          else
            successor.left = nil
            count = count + 1
            puts "n(#{n})th Smallest Element :: #{current.value.to_s}" if count == n
            current = current.left
          end
        end
      end
   end
    
    private
    
    # Support method to find nth smallest element using extra storage space
    # @param node [Node]
    # @param n [Numeric]
    # @param lr_count_store [Hash]
    # @return [Node]
    #
    def find_nth_smallest_element(node, n, lr_count_store)
      return nil if node.nil?
      n_new = n - (lr_count_store[node.object_id][:left_nodes_count] + 1)
      return node.value.to_s if n_new.zero?
      return find_nth_smallest_element(node.left, n, lr_count_store)  if n_new < 0
      find_nth_smallest_element(node.right, n_new, lr_count_store)
    end

    # Support method to find nth largest element using extra storage space
    # @param node [Node]
    # @param n [Numeric]
    # @param lr_count_store [Hash]
    # @return [Node]
    #
    def find_nth_largest_element(node, n, lr_count_store)
      return nil if node.nil?
      n_new = n - (lr_count_store[node.object_id][:right_nodes_count] + 1)
      return node.value.to_s if n_new.zero?
      return find_nth_largest_element(node.right, n, lr_count_store)  if n_new < 0
      find_nth_largest_element(node.left, n_new, lr_count_store)
    end
  end
end