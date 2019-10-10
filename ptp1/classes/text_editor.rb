# A class used to read text files
# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
class TextEditor
  # content returns an alphabetically sorted word list where :
  # * all non-word characters are removed
  # * upcase characters are replaced by downcase ones
  attr_reader :content, :word_list
  # Initialize a new instance of *TextEditor*
  # @param path: The path to the text file
  def initialize(path)
    File.open(path) { |f| @content = f.read }
    @word_list = get_word_list(@content)
  end

  # Returns an array of each word in @param
  def get_word_list(content)
    words = content.split
    word_list = []
    # filter the words list
    words.each do |word|
      # replace all upcase characters with downcase ones
      w = word.downcase
      # remove all non-letters characters
      w.gsub!(/\W/, '')
      # remove all whitespaces
      w.gsub!(/\s+/, '')
      # only all non-empty word to the filtered list
      word_list.push(w) unless w.empty?
    end
    word_list
  end

  # Returns the words list, where each word is inverted
  def reverse_words
    reversed_word_list = []
    @word_list.each { |word| reversed_word_list.push(word.reverse) }
    # return the reversed word list
    reversed_word_list
  end

  # Saves the given wordlist in a file in the given path wit one word per line
  def to_file(wordlist, filepath)
    text = wordlist.join("\n")
    File.open(filepath, 'w') { |f| f.write text }
  end

  # Returns a Hash where:
  # * *key* is the word
  # * *value* is the occurrence of the usage of the word in the words list
  def word_occurrence
    # the default value of the occurrence of a word is 0
    word_count = Hash.new(0)
    @word_list.each { |word| word_count[word] += 1 }
    word_count
  end
end