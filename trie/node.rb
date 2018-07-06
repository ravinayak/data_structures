# Used for namespacing
#
module Trie
  # Class
  #
  class Node
    
    # Attribute Accessors
    #
    attr_accessor :char, :is_end_of_word, :left, :right, :mid
    
    def initialize(char: char, is_end_of_word: false, left: nil, mid: nil, right: nil)
      @char = char
      @is_end_of_word = is_end_of_word
      @left = left
      @mid = mid
      @right = right
    end
  end
end
