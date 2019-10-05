# A class used to make statistics about word lists
# Author::Youssef Benlemlih
class WordsStat
    # Initialize a new instance of WordsStat
    # @param word_list : an array of the words to make statistics about
    def initialize(word_list)
        @word_list = word_list
    end

    # Returns a Hash where:
    # * *key* is the word
    # * *value* is the percentage of the usage of the word in the words list
    def get_statistics
        # the defaut value of the usage of a word is 0
        statistics_count = Hash.new(0)
        @word_list.each do |word|
            statistics_count[word]+=1
        end

        total_count = @word_list.length.to_f
        statistics_percent=Hash.new(0)
        statistics_count.each do |key,value|
            # compute the percentage of the usage of each word
            statistics_percent[key]=value/total_count*100
        end
        statistics_percent
    end
end