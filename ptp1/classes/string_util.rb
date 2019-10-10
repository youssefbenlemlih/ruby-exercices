# A utility class to make string operations.
# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
class StringUtil
  # A static method that returns the reversed string
  def self.reverse(string)
    string.reverse
  end

  # A static method that returns a copy of string with all lowercase letters
  # replaced with their uppercase counterparts.
  def self.upcase(string)
    string.upcase
  end

  # A static method that returns a copy of string with all uppercase letters
  # replaced with their downcase counterparts.
  def self.downcase(string)
    string.downcase
  end

  # A static method that returns a copy of string with all uppercase letters
  # replaced with their downcase counterparts and otherwise.
  def self.swapcase(string)
    string.swapcase
  end

  # A static method that returns a copy of string
  # with all the vocals are replaced by '*'
  def self.censor_small_vowels(string)
    string.gsub(/[aeiou]/, '*')
  end

  # A static method that returns a copy of string with all the consonants
  # are doubled and an o is put in between.
  # *Example:* 'StringUtil.kokify('ist') #=> 'isospop'
  def self.kokify(string)
    string.gsub(/(?<match>[^aeiouAEIOU\d])/, '\k<match>o\k<match>')
  end
end