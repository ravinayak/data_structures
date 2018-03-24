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
    #       In-Order traversal is performed using Stack
    #   2.  In-Order Traversal with O(1) storage space (Morris Traversal) => This approach
    #       does not need any extra storage space and uses threading concepts to traverse a
    #       tree in-order. We maintain count variable to keep count of nth smallest element.
    #       To find nth largest element, we do a reverse in-order traversal and keep count.
    #   3.  Augmenting BST => We augment BST such that it includes information about count
    #       of nodes. This count can be used to find nth smallest/largest elements. It can
    #       be used to answer Range Media Queries
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
    
    private
    
    # Support method to find nth smallest element using
    # O(1) storage space
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
  end
end