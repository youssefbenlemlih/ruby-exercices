# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'yaml'
module FileHandler

  def self.load_yaml(name)
    path = FileHandler.search(name)
    raise(StandardError, "No partlist belonging to #{name}!") if path.empty?

    YAML.load_file(path)
  end

  # @return [String] path string of first file where str was found or empty string
  def self.search(str)
    Dir['parts/*.yml'].each do |path|
      File.open(path) do |file|
        content = file.read.chomp.downcase
        return path unless content[str.downcase].nil?
      end
    end
    ''
  end

end