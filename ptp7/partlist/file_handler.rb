# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
module FileHandler

  def self.part_path(filename)
    Dir["parts/#{filename}.txt"].empty? ? '' : "parts/#{filename}.txt"
  end

  def self.exists?(filename)
    return false if part_path(filename) == ''
    true
  end

  def self.subparts(filename)
    path = part_path(filename)
    parts = []
    File.open(path) do |file|
      rows = file.read.chomp.split("\n")
      rows.each do |i|
        item = i.split(',')
        parts << {:name => item[0], :mass => item[1].nil? ? 0 : convert_mass(item[1])}
      end
    end
    parts
  end

  def self.mass(path, partname)
    File.open(path) { |file|
      m = file.read.chomp[/#{partname},([\w.]*)/, 1]
      return convert_mass(m) unless m.nil? # TODO: Warum ist m immer nil..?

      -1
    }
  end

  def self.convert_mass(str)
    unit = str[/[a-zA-Z]/]
    val = str.to_f
    val /= 1000 if unit == 'g'
    val
  end

  # @return [String] path string of first file where str was found or empty string
  def self.search(str)
    Dir['parts/*.txt'].each do |path|
      File.open(path) do |file|
        content = file.read.chomp.downcase
        return path unless content[str.downcase].nil?
      end
    end
    ''
  end

  def self.filename(path)
    File.basename(path).sub(/\..*/, '')
  end
end