module FileHandler

  def self.part_path(filename)
    Dir["parts/#{filename}.txt"].empty? ? '' : "parts/#{filename}.txt"
  end

  def self.exists?(filename)
    return false if part_path(filename) == ''
    true
  end

  def self.subparts(path)
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

  def self.convert_mass(str)
    unit = str[/[a-zA-Z]/]
    val = str.to_f
    val /= 1000 if unit == 'g'
    val
  end

end