# Author::Youssef Benlemlih
# A class used to read text files,
class TextEditor
    # Initialize a new instance of *TextEditor*
    # @param filename: The path to the text file
    def initialize(path)
        @filestream = File.open(path)
        @content = @filestream.read
    end

    # Returns raw the content of the file
    def get_raw_content
        @content
    end

    # Returns an alphabetically sorted word list where :
    # * all non-word characters are removed
    # * upcase characters are replaced by downcase ones
    def get_words_list
        words_list = @content.split
        filtered_word_list=[]
        # filter the words list
        words_list.each do |word|
            # replace all upcase characters with downcase ones
            w = word.downcase
            # remove all non-letters characters
            w.gsub!(/\W/,'')
            # remove all whitespaces
            w.gsub!(/\s+/,'')
            # only all non-empty word to the filtered list
            if !w.empty? then
                filtered_word_list.push(w)          
            end
        end
        # sort the filtered word list alphabetically
        filtered_word_list.sort!
        # return the filtered word list
        filtered_word_list
    end

    # Returns the words list, where each word is inverted
    def get_reversed_words_list
        reversed_word_list=[]
        get_words_list.each do |word|
            reversed_word_list.push(word.reverse)
        end
        # return the reversed word list
        reversed_word_list
    end

    # Saves the given wordlist in a file in the given path wit one word per line
    def self.save_word_list_to_file(wordlist,filepath)
        text = wordlist.join("\n");
        file = File.new(filepath,'w')
        file.write text
        file.close
    end
end