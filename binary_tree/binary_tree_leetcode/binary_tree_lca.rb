# Used for namespacing
#
module BinaryTree
  # Includes methods for finding lowest common ancestor for a node
  # in Binary Search Tree / Binary Tree
  #
  module BinaryTreeLca
    # Method to find lowest common ancestor of a node in a BST
    #
    # The algorithm is straight forward
    #
    # When two nodes are given, we compare the values of those two nodes with node in the BST
    # starting from root, and go left or right depending upon the result of comparison
    # For any two given node values (a, b) and a node in BST (node n), only following cases are
    # possible -
    #
    #       Vn represents value at node n
    #
    #     |   1.  a < Vn && b > Vn    |
    #     |   2.  a > Vn && b < Vn    |    In all of these cases, node n is the LCA of a and b
    #     |   3.  a = Vn && b > Vn    |    node n represents the node at deepest level from
    #     |   4.  a = Vn && b < Vn    |    root which has both "a" and "b" as descendants
    #     |   5.  b = Vn && a > Vn    |    Here a node is considered a descendant of itself
    #     |   6.  b = Vn && a < Vn    |
    #     |   7.  b = Vn && a = Vn    |
    #
    #     All of the above use cases can be summarized into one condition which is
    #         ( a <= Vn && b >= Vn || a >= Vn && b <= Vn )
    #
    #     The above condition is what remains after considering the below two conditions
    #
    #         8.  a > Vn && b > Vn    |    Here LCA lies to the left of node n
    #         9.  a < Vn && b < Vn    |    Here LCA lies to the right of node n
    #
    def find_lca_bst(node, n1, n2)
      return nil if node.nil?
      return find_lca_bst(node.left, n1, n2) if (n1.value < node.value && n2.value < node.value)
      return find_lca_bst(node.right, n1, n2) if (n1.value > node.value && n2.value > node.value)
      node
    end

    # The problem of finding an LCA is not simple for a Binary Tree since it does not have the search
    # order property where value at a node is greater than or equal to the value of node at its left
    # and value at node is less than value of node at its right
    #
    # Typically, we follow two methods -
    #
    # Method A
    #
    # 1.  Traverse the entire tree twice searching for the two nodes, and in the process we build
    #     paths from root to each node. This should give us the array of nodes for each path
    # 2.  Compare nodes in two path arrays, the index at which the similarity ends, the node in the
    #     preceding location of the array will be the LCA
    #
    # Method B
    #
    # 1.  Traverse tne tree only once searching for nodes n1, node n2, and mark the LCA for node in
    #     this search
    #
    def find_lca_binary_tree_met_1(node, n1, n2)
      # This method needs a path array and an index to keep track of the nodes in the path from
      # root to n1 and from root to n2.
      # The two paths obtained from root to node n1 and node n2 are then compared node by node
      # The first node where the comparison fails for similarity is the LCA
      #


      # These two methods find the paths to node n1 and node n2 from root
      #
      options = prepare_options_hash(node, n1)
      root_to_n1_path = find_lca_bt_met_1_support(options)

      options = prepare_options_hash(node, n2)
      root_to_n2_path = find_lca_bt_met_1_support(options)

      # This method traverses the two path arrays from root to node n1 and node n2. The first index at which
      # nodes stop becoming same is the LCA
      #
      find_lca_by_comparing_paths(root_to_n1_path, root_to_n2_path)
    end

    def find_lca_binary_tree_met_2(node, n1, n2)
      # This method traverses down from the root to each node in the tree
      # and finds the nodes n1 and n2. If node n1 or node n2 is the ancestor
      # of another node, then that node is returned. Else, the node deepest
      # from root which has n1 and n2 as its left and right is found as the node
      # and is returned as LCA
      #
      node_hash = {}
      find_lca_bt_met_2_support(node, n1, n2, node_hash)[:node]
    end

    private

    # Support method to find LCA for a binary tree for method 1
    #
    def find_lca_bt_met_1_support(options)
      return options[:path] if options[:node].nil?
      return options[:path] if options[:found_hash][:found]

      path, index, node, node_to_find, found_hash =
          options[:path], options[:index], options[:node], options[:node_to_find], options[:found_hash]

      path[index] = node
      index += 1
      found_hash[:found] = true if node.value == node_to_find.value
      return path if found_hash[:found]

      options[:node], options[:index] = node.left, index
      find_lca_bt_met_1_support(options)

      options[:node], options[:index] = node.right, index
      find_lca_bt_met_1_support(options)
    end

    # Support method to find LCA for a binary tree for method 2
    #
    def find_lca_bt_met_2_support(node, n1, n2, node_hash)
      return {} if node.nil?
      return node_hash unless node_hash[:node].nil?

      assign_node(node, n1, n2, node_hash)
      return node_hash unless node_hash[:node].nil?

      left_res = {}
      find_lca_bt_met_2_support(node.left, n1, n2, left_res)
      node_hash.merge!(left_res) unless left_res.empty?
      node_hash[:node] = node if node_assignment_valid?(node_hash)
      return node_hash unless node_hash[:node].nil?

      right_res = {}
      find_lca_bt_met_2_support(node.right, n1, n2, right_res)
      node_hash.merge!(right_res) unless right_res.empty?
      node_hash[:node] = node if node_assignment_valid?(node_hash)
      node_hash
    end

    # This method traverses the two path arrays to find LCA for nodes n1 and n2
    #
    def find_lca_by_comparing_paths(root_to_n1_path, root_to_n2_path)
      # This variable holds the smaller length of the two path arrays
      # Iteration should be performed only till the end of one of the two
      # path arrays (smaller path array)
      #
      length = root_to_n1_path.length > root_to_n2_path.length ? root_to_n2_path.length : root_to_n1_path.length
      i = 0
      while i < length && root_to_n1_path[i] == root_to_n2_path[i]
        i += 1
      end
      # Return the last node where the path arrays stop becoming same
      # This node is farthest from the root and deepest ancestor
      # and hence is the LCA

      #
      # 1 is subtracted from i to decrement to bring it to the last index
      # where the nodes were same
      #
      root_to_n1_path[i-1]
    end

    # This method evaluates if node has value same as nodes n1 and n2. If nodes n1 and n2
    # have been found, but node has not been assigned, then it assigns node
    #
    def assign_node(node, n1, n2, node_hash)
      assign_flag(node_hash, node, n1, :n1)
      assign_flag(node_hash, node, n2, :n2)
      return unless node_hash[:n1] && node_hash[:n2]
      node_hash[:node] = node if node_hash[:node].nil?
    end

    # This method compares node value with n1 and n2 and assigns the corresponding flag to true
    # in node_hash
    #
    def assign_flag(node_hash, node, node_to_find, node_sym)
      node_hash[node_sym] = true if node.value == node_to_find.value
    end

    # This method evaluates if node should be assigned to node_hash
    #
    def node_assignment_valid?(node_hash)
      node_hash[:n1] && node_hash[:n2] && node_hash[:node].nil?
    end

    # This method generates an options hash to process
    #
    def prepare_options_hash(node, node_to_find)
      path, index = [], 0
      {
          path: path, index: index, node: node, node_to_find: node_to_find, found_hash: { found: false }
      }
    end
  end

  # require '/Users/ravinayak/Documents/personal_projects/data_structures/binary_tree/binary_tree'
  # bt = BinaryTree::BinaryTree.new
  # node = BinaryTree::Node.new
  # node.value = 700
  # node_700 = BinaryTree::Node.new
  # node_700.value = 700
  # node_600 = BinaryTree::Node.new
  # node_600.value = 600
  # node_900 = BinaryTree::Node.new
  # node_900.value = 900
  # node_1000 = BinaryTree::Node.new
  # node_1000.value = 1000
  # node_100 = BinaryTree::Node.new
  # node_100.value = 100
  # node_200 = BinaryTree::Node.new
  # node_200.value = 200
  # node_300 = BinaryTree::Node.new
  # node_300.value = 300
  # node_400 = BinaryTree::Node.new
  # node_400.value = 400
  # node_1400 = BinaryTree::Node.new
  # node_1400.value = 1400
  # node_1600 = BinaryTree::Node.new
  # node_1600.value = 1600
  # node_500 = BinaryTree::Node.new
  # node_500.value = 500
  # node_1800 = BinaryTree::Node.new
  # node_1800.value = 1800
  # node_1100 = BinaryTree::Node.new
  # node_1100.value = 1100
  # node_1100 = BinaryTree::Node.new
  # node_1100.value = 1100
  # node_1200 = BinaryTree::Node.new
  # node_1200.value = 1200
  # node_1300 = BinaryTree::Node.new
  # node_1300.value = 1300
  # node_700.left = node_600
  # node_700.right = node_1400
  # node_600.left = node_900
  # node_600.right = node_200
  # node_900.left = node_1000
  # node_900.right = node_100
  # node_200.left = node_300
  # node_200.right = node_400
  # node_1400.left = node_1600
  # node_1400.right = node_1100
  # node_1600.left = node_500
  # node_1600.right = node_1800
  # node_1100.left = node_1200
  # node_1100.right = node_1300
  # node_1000.left = node_1000.right = nil
  # [node_300, node_100, node_400, node_500, node_1800, node_1200, node_1300].each do |n|
  #   n.left = n.right = nil
  # end

  # bt.root = node_700
  # bt.find_lca_binary_tree_met_2(bt.root, node_300, node_400)
  # bt.find_lca_binary_tree_met_1(bt.root, node_300, node_400)
  # Search for some other nodes
  #
end
