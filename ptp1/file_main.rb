# A script that opens text files from the directory INPUT_DIR and
# * Prints the content of the text file in the console
# * Print the words in the file, one per line
# * Saves the reversed words in a new file, one per line
# * Prints statistics about the words usage
# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

require_relative './classes/text_editor'

# A helper function to output the titles
def output(string)
  puts('===========================================')
  puts(string)
  puts('-------------------------------------------')
end

# The names of the files in INPUT_DIR
# This can also be done programatically to open all files in the directory
file_names = ["example_file.txt", "picasso.txt"]
file_names.each do |file_name|
  text_editor = TextEditor.new("data/#{file_name}")
  # Question 2.2
  # Print the words of the file, one per line
  output "The words list of '#{file_name}' :"
  words_array = text_editor.words_to_array(text_editor.content)
  words_array.each { |word| puts word }
  # Question 2.3
  # Saving the reversed words in a new file
  output "Saving reversed words list of '#{file_name}'..."
  reversed_words = text_editor.reverse_words(words_array)
  text_editor.to_file(reversed_words, "data/result_#{file_name}")
  # Question 2.4
  # Words statistics
  output "Word statistics of #{file_name}"
  # print the statistics in a table
  text_editor.words_occurrences(words_array).each do |key, value|
    puts "#{key}:#{' ' * (20 - key.length)}:  #{value}"
  end
end