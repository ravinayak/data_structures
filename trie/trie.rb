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
      search_word_prep(word, @root, index: 0)
    end
    
    def level_display
      stack = Stack::Stack.new
      prep_level_display(stack)
    end
    
    private
    
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
    
    def search_word_prep(word, node, index: index)
      return false if node.nil?
      
      word_char = word[index].downcase
      if word_char != '.' && word_char < node.char.downcase
        search_word_prep(word, node.left, index: index)
      elsif word_char != '.' && word_char > node.char.downcase
        search_word_prep(word, node.right, index: index)
      elsif index < word.length - 1
        search_word_prep(word, node.mid, index: index + 1)
      elsif node.is_end_of_word
        return true
      else
        false
      end
    end
  end
end

# To run True
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/trie/trie'
# trie = Trie::Trie.new
# trie.add_word('bad')
# trie.add_word("dad")
# trie.add_word("mad")
# trie.search_word("pad")
# trie.search_word("bad")
# trie.search_word(".ad")
# trie.search_word("b..")
#
