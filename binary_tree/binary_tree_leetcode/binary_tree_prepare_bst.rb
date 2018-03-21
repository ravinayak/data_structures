# Used for namespacing
#
module BinaryTree
  # Includes methods to prepare Binary Search Tree
  #
  module BinaryTreePrepareBst

    # BST can be prepared from sorted array or a sorted linked list
    # Twp Approaches can be taken
    #   - 1. Prepare BST from root to leaves
    #   - 2. Prepare BST from leaves to root
    # Since the data structure is sorted, we can take the middle element as the root
    # All elements to the left of the middle element will be less than the middle element
    # while all elements to the right of the middle element will be greater than the middle element
    # We can construct the left subtree from elements to the left of the middle element,
    # and right substree from elements to the right of the middle element. This BST will be balanced
    # We can apply the steps outlined above recursively to the left half and middle half, and hence
    # construct the BST.
    #
    # In case of Linked List we would need to traverse the list again and again to find values of nodes
    # we intend to create if they are not in serial order, this would increase time complexity.
    # An alternative approach is to create tree from leaves to root. In this case, we recursively traverse
    # until we reach the 1st node, create a node for tree, this would be the leaf and then assign it to
    # the parent node. This way we encounter nodes in serial order and we have to traverse the list only twice
    # - 1. To get length of the list 2. To prepare BST
    # The algorithm works in the following way,
    #   a. Assign current to header of list
    #   b. Create left node by repeatedly traversing left
    #   c. Create root node by advancing the current pointer to next node
    #   d. Create right node by traversing right and pass current to this recursion
    #   e. Assign left and right to root
    #   f. Return root
    #
    # Prepares BST from Sorted Array
    # @params arr [Array]
    # @return [Node]
    #
    def prep_balanced_bst_sorted_arr(arr)
      # Array Index starts at 0
      #
      bst_sorted_arr_support(arr, 0, arr.length - 1)
    end

    # Prepares BST from Sorted Linked List
    # @params list [LinkedList]
    # @return [Node]
    #
    def prep_balanced_bst_sorted_list(list)
      length = list &.determine_length
      return nil if length.nil?
      # Linked List length starts from 1 and goes till length of list
      #
      # We need a hash here because we want the value of current to change across recursion. If we
      # change the value of current in any step of recursion deep down, and come back to the previous level
      # then , due to stack holding the value, the previous value of current would be retained and the change
      # would not be reflected. To reflect the change in current we pass a hash and change the value of key
      #
      curr_hash = { curr: list.head }
      bst_sorted_list_support(curr_hash, 1, length)
    end

    private

    # Support method to prepare BST
    # @params arr [Array]
    # @params start_index [Integer]
    # @params end_index [Integer]
    # @return [Node]
    #
    def bst_sorted_arr_support(arr, start_index, end_index)
      return nil if start_index > end_index
      mid_index = ((start_index + end_index)/2).floor
      node = Node.new
      node.value = arr[mid_index]
      node.left = bst_sorted_arr_support(arr, start_index, mid_index - 1)
      node.right = bst_sorted_arr_support(arr, mid_index + 1, end_index)
      node
    end

    # Support method to prepare BST
    # @params curr_hash [Hash containing pointer to Current Node]
    # @params start_index [Integer]
    # @params end_index [Integer]
    # @return [Node]
    #
    def bst_sorted_list_support(curr_hash, start_index, end_index)
      return nil if start_index > end_index
      mid_index = ((start_index + end_index)/2).floor
      left_subtree = bst_sorted_list_support(curr_hash, start_index, mid_index - 1)
      node = Node.new
      curr = curr_hash[:curr] &.next_node
      node.value = curr &.value
      # This will change the value of curr across recursion
      #
      curr_hash[:curr] = curr
      right_subtree = bst_sorted_list_support(curr_hash, mid_index + 1, end_index)
      node.left = left_subtree
      node.right = right_subtree
      node
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/binary_tree/binary_tree'
# require '/Users/ravinayak/Documents/personal_projects/data_structures/linked_list/linked_list'
# bt = BinaryTree::BinaryTree.new
# a = [4, 6, 9, 13, 45, 67, 89, 95, 112]
# list = LinkedList::LinkedList.new
# a.each { |val| list.add_node(val) }
# bt.prep_balanced_bst_sorted_list(list)
# bt.prep_balanced_bst_sorted_arr(a)
