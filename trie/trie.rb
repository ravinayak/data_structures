require_relative '../trie/node'
require_relative '../stack/stack'

# Used for namespacing
#
module Trie
  # Class
  #
  class Trie
    
    attr_accessor :root
    
    def initialize(root: nil)
      @root = root
    end
    
    def add_word(word)
      @root = prep_add_word(word, @root, index: 0)
    end
    
    def search_word(word)
      res = search_word_prep(word, @root, index: 0, parent_node_arr: { }, store_nodes: false)[:search_result]
      res.nil? ? false : res
    end
    
    def level_display
      stack = Stack::Stack.new
      prep_level_display(stack)
    end
    
    def delete_word(word, hard_delete: false)
      delete_word_prep(word, hard_delete: hard_delete)
    end
    
    private
    
    def delete_word_prep(word, hard_delete: hard_delete)
      node_res_hash = search_word_prep(word, @root, index: 0, parent_node_arr: { })
      return { message: 'Element was not found' } unless node_res_hash[:search_result]
      
      node_arr = node_res_hash[:parent_node_arr][:node_arr]
      node_arr[node_arr.length - 1].is_end_of_word = false
      return { message: 'Element successfully deleted' } unless hard_delete

      (0...node_arr.length).each do |node|
        if node.left.nil? && node.right.nil?
          node.mid = nil
          node = nil
        end
      end
    end
    
    def prep_level_display(stack)
      return 'Trie is Empty' if @root.nil?
      stack.push(@root)
      until stack.empty?
        arr = []
        until stack.empty?
          arr << stack.pop
        end
        arr.each { |node| print node.char + '  ' }
        puts
        arr.reverse.each do |node|
          stack.push(node.right) unless node.right.nil?
          stack.push(node.mid) unless node.mid.nil?
          stack.push(node.left) unless node.left.nil?
        end
      end
    end
    
    def prep_add_word(word, node, index: index)
      word_char = word[index].downcase
      
      node = Node.new(char: word_char) if node.nil?
      if word_char > node.char
        node.right = prep_add_word(word, node.right, index: index)
      elsif word_char < node.char
        node.left = prep_add_word(word, node.left, index: index)
      elsif index < word.length - 1
        node.mid = prep_add_word(word, node.mid, index: index + 1)
      else
        node.is_end_of_word = true
      end
      
      node
    end
    
    def search_word_prep(word, node, index: index, parent_node_arr: parent_node_arr, store_nodes: store_nodes)
      return { parent_node_arr: parent_node_arr, search_result: false } if node.nil?
      
      word_char = word[index].downcase
      parent_node_arr[:node_arr] << node if store_nodes
      
      if word_char != '.' && word_char < node.char.downcase
        search_word_prep(word, node.left, index: index, parent_node_arr: parent_node_arr)
      elsif word_char != '.' && word_char > node.char.downcase
        search_word_prep(word, node.right, index: index, parent_node_arr: parent_node_arr)
      elsif index < word.length - 1
        search_word_prep(word, node.mid, index: index + 1, parent_node_arr: parent_node_arr)
      else
        { parent_node_arr: parent_node_arr, search_result: node.is_end_of_word }
      end
    end
  end
end

# To run True
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/trie/trie'
# trie = Trie::Trie.new
# trie.add_word('bad')
# trie.delete_word('bad')
# trie.add_word("dad")
# trie.add_word("mad")
# trie.search_word("pad")
# trie.search_word("bad")
# trie.search_word(".ad")
# trie.search_word("b..")
# trie.search_word('.a.')
