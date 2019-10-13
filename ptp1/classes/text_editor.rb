# A class used to read text files
# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
class TextEditor
  attr_reader :content
  # Initialize a new instance of *TextEditor*
  # with String @content
  # @param path: The path to the text file
  def initialize(path)
    File.open(path) { |f| @content = f.read }
  end

  # Returns an array of each word in @param
  def words_to_array
    words = @content.split
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
    @content = word_list
    nil
  end

  # Returns the words list as an array, where each word is inverted
  def reverse_words
    reversed_word_list = []
    @content.each { |word| reversed_word_list.push(word.reverse) }
    # return the reversed word list
    @content = reversed_word_list
    nil
  end

  # Saves the given wordlist in a file in the given path wit one word per line
  def to_file(filepath)
    text = @content.join("\n")
    File.open(filepath, 'w') { |f| f.write text }
    nil
  end

  # Returns a Hash where:
  # * *key* is the word
  # * *value* is the occurrence of the usage of the word in the words list
  def words_occurrences
    # the default value of the occurrence of a word is 0
    word_count = Hash.new(0)
    @content.each { |word| word_count[word] += 1 }
    word_count
  end

end