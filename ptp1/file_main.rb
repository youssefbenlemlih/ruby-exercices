# A script that opens text files from the directory INPUT_DIR and
# * Prints the conten of the text file in the console
# * Print the words in the file, one per line
# * Saves the reversed words in a new file, one per line
# * Prints statistics about the words usage
# Author::Youssef Benlemlih

require_relative'./classes/text_editor'
require_relative'./classes/words_stat'

# A helper function to output the titles
def output(string)
    puts('===========================================')
    puts(string)
    puts('-------------------------------------------')
end

# The directory where the files are read from
INPUT_DIR ='./input_files'
# The directory where the files are saved to
OUTPUT_DIR='./output_files'

# The names of the files in INPUT_DIR
# This can also be done programatically to open all files in the directory
file_names =["example_file.txt","picasso.txt"]
file_names.each do |file_name|
    text_editor = TextEditor.new("#{INPUT_DIR}/#{file_name}")
    # Question 2.1
    # Print the content of the file
    output"The content of '#{file_name}' :"
    puts text_editor.get_raw_content
    # Question 2.2
    # Print the words in the file, one per line
    output"The words list of '#{file_name}' :"
    words = text_editor.get_words_list
    words.each do |word|
        puts word 
    end
    # Question 2.3 
    # Saving the reversed words in a new file
    output "Saving reversed words list of '#{file_name}' :"
    reversed_words = text_editor.get_reversed_words_list
    TextEditor.save_word_list_to_file(reversed_words,"#{OUTPUT_DIR}/#{file_name}")
    # Question 2.4
    # Words statistics
    output "Word statistics of #{file_name}"
    stat = WordsStat.new(words)
    stat.get_statistics.each do |key, value|
        # print the statistics in a table 
        puts "#{key}:#{' '*(20-key.length)}:  #{value}"
    end
end