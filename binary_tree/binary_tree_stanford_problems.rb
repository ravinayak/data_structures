# Used for namespacing
#
module BinaryTree
  # Includes solutions for binary tree problems
  #
  module BinaryTreeStanfordProblems
    # Constants to hold min and max values
    #
    FIXNUM_MAX = (2**(0.size * 8 -2) -1)
    FIXNUM_MIN = -(2**(0.size * 8 -2))

    # Counts the number of nodes in the tree
    # @return [Integer]
    #
    def size
      size_support(self.root)
    end

    # Returns maximum depth of a binary tree
    # @return [Integer]
    #
    def depth
      depth_support(self.root)
    end

    # Returns true if there exists a path in the tree from root to leaf which
    # adds up to the given sum
    # @param node [Node]
    # @param sum [Integer]
    # @return [TrueClass/FalseClass]
    #
    def has_path_sum(node, sum)
      return false if node.nil?
      sub_sum = sum - node.value
      return true if sub_sum == 0 && node.left.nil? && node.right.nil?
      has_path_sum(node.left, sub_sum) || has_path_sum(node.right, sub_sum)
    end

    # Prints all the paths from the root to the leaf node in a tree
    # @return [NIL]
    #
    def print_paths
      path, counter = [], 0
      puts '************************ Tree Paths ***********************************'
      puts
      print_tree_paths(self.root, path, counter)
      puts
      puts '***********************************************************************'
    end

    # Creates a new tree that mirrors the original tree
    # @return [Node]
    #
    def create_mirror_tree
      node = ::BinaryTree::Node.new
      create_mirror_tree_support(self.root, node)
      display_support(node)
    end

    # Mirrors the original tree
    # @return [Node]
    #
    def mirror_tree
      mirror_tree_support(self.root)
      display_support(self.root)
    end

    # Doubles tree
    # @return [Node]
    #
    def create_double_tree
      node = ::BinaryTree::Node.new
      create_double_tree_support(self.root, node)
      display_support(node)
    end

    # Returns true if tree is same
    # @param node [Node]
    # @return [TrueClass/FalseClass]
    #
    def same_tree(node)
      same_tree_support(self.root, node)
    end

    # Checks if a tree is a BST
    # @return [TrueClass/FalseClass]
    #
    def is_bst
      is_bst_bool_hash =  { is_bst_bool: true }
      is_bst_support(self.root, FIXNUM_MIN, FIXNUM_MAX, is_bst_bool_hash)
      print is_bst_bool_hash[:is_bst_bool]
    end

    # Counts the number of trees
    # @return [Integer]
    #
    def count_num_trees
      print 'Please enter the upper number :: '
      num_keys = gets.chomp.to_i
      sum = count_num_trees_supp(num_keys)
      puts "Possible different binary trees having unique structure :: #{sum}"
    end

    # Counts number of trees for a given array
    # @return [Integer]
    #
    def count_num_of_arr_trees
      print 'Please enter the numbers in array separated by space :: '
      arr = gets.split(' ')
      arr.sort!
      sum = num_of_arr_trees_supp(arr, 0, arr.length-1)
      puts "Possible different binary trees having unique structure :: #{sum}"
    end

    # Private Methods
    #
    private

    # Helper method to prints paths in a tree
    # @param node [Node]
    # @param path [Array]
    # @param counter [Integer]
    # @return [NIL]
    #
    def print_tree_paths(node, path, counter)
      return if node.nil?
      path[counter] = node
      counter += 1
      return print_nodes(path, counter) if node.left.nil? && node.right.nil?
      print_tree_paths(node.left, path, counter) unless node.left.nil?
      print_tree_paths(node.right, path, counter) unless node.right.nil?
    end

    # Helper method to print the paths in an array
    # @param path [Array]
    # @param counter [Integer]
    # @return [NIL]
    #
    def print_nodes(path, counter)
      (0..(counter - 1)).each { |i| print path[i].value.to_s + '  ' }
      puts
    end

    # Support method for determining size of a tree
    # @param node [Node]
    # @return [Integer]
    #
    def size_support(node)
      return 0 if node.nil?
      size_support(node.left) + 1 + size_support(node.right)
    end

    # Finds the maximum depth of a tree
    # @param node [Node]
    # @return [Integer]
    #
    def depth_support(node)
      return 0 if node.nil?
      l_depth = depth_support(node.left)
      r_depth = depth_support(node.right)
      [l_depth, r_depth].max + 1
    end

    # Support method to mirror tree
    # @param node [Node]
    # @return [Node]
    #
    def mirror_tree_support(node)
      return if node.nil?
      tmp = node.left
      node.left = node.right
      node.right = tmp
      mirror_tree_support(node.left)
      mirror_tree_support(node.right)
    end

    # Support method to create mirror tree
    # @param original_node [Node]
    # @param mirror_node [Node]
    # @return [Node]
    #
    def create_mirror_tree_support(original_node, mirror_node)
      return if original_node.nil? || mirror_node.nil?
      mirror_node.value = original_node.value
      mirror_node.left = ::BinaryTree::Node.new unless original_node.right.nil?
      mirror_node.right = ::BinaryTree::Node.new unless  original_node.left.nil?
      create_mirror_tree_support(original_node.right, mirror_node.left)
      create_mirror_tree_support(original_node.left, mirror_node.right)
    end

    # Double Tree Support Method
    # @param original_node [Node]
    # @param double_tree_node [Node]
    # @return [Node]
    #
    def create_double_tree_support(original_node, double_tree_node)
      return if original_node.nil? || double_tree_node.nil?
      double_tree_node.value = original_node.value
      node = ::BinaryTree::Node.new
      node.value = original_node.value
      double_tree_node.left = node
      node.left = ::BinaryTree::Node.new unless original_node.left.nil?
      double_tree_node.right = ::BinaryTree::Node.new unless original_node.right.nil?
      create_double_tree_support(original_node.left, node.left)
      create_double_tree_support(original_node.right, double_tree_node.right)
    end

    # Returns true if tree is same as given binary tree
    # @param original_node [Node]
    # @param second_node [Node]
    # @return [TrueClass/FalseClass]
    #
    def same_tree_support(original_node, second_node)
      return false if ((original_node.nil? && !second_node.nil?) || (!original_node.nil? && second_node.nil?))
      return true if original_node.nil? && second_node.nil?
      original_node.value == second_node.value &&
          same_tree_support(original_node.right, second_node.right) &&
          same_tree_support(original_node.left, second_node.left)
    end

    # Support method to check if a tree is a BST
    # @param node [Node]
    # @param min [Integer]
    # @param max [Integer]
    # @param is_bst_bool_hash [Hash]
    # @return [TrueClass/FalseClass]
    #
    def is_bst_support(node, min, max, is_bst_bool_hash)
      return true if node.nil?

      is_bst_support(node.left, min, node.value, is_bst_bool_hash)
      left_is_bst = valid_node_data?(node.left, min, node.value)

      is_bst_support(node.right, node.value + 1, max, is_bst_bool_hash)
      right_is_bst = valid_node_data?(node.right, node.value + 1, max)

      is_bst_bool_hash[:is_bst_bool] = false unless left_is_bst && right_is_bst
    end

    # Determines boolean value based on range comparison
    # @param node [Node]
    # @param min_val [Integer]
    # @param max_val [Integer]
    # @return [TrueClass/FalseClass]
    #
    def valid_node_data?(node, min_val, max_val)
      return true if node.nil?
      return true if node.value > min_val && node.value < max_val
      false
    end

    # Support method to count the number of trees
    # @param num_keys [Integer]
    # @return [Integer]
    #
    def count_num_trees_supp(num_keys)
      return 1 if num_keys <= 1
      sum_total = 0
      (1..num_keys).each do |val|
        sum = 0
        left_count = count_num_trees_supp(val - 1)
        right_count = count_num_trees_supp(num_keys - val)
        sum += left_count * right_count
        sum_total += sum
      end
      sum_total
    end

    # Support method to count the number of trees for a given array
    # @param arr [Array]
    # @return [Integer]
    #
    def num_of_arr_trees_supp(arr, start_index, end_index)
      return 1 if start_index > end_index
      i = start_index
      sum = 0
      while i <= end_index
        left_count =  num_of_arr_trees_supp(arr, start_index, i - 1)
        right_count = num_of_arr_trees_supp(arr, i + 1, end_index)
        sum += left_count * right_count
        i+=1
      end
      sum
    end
  end
end
