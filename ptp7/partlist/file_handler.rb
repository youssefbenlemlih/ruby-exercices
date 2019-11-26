module FileHandler

  def self.part_path(filename)
    Dir["parts/#{filename}.txt"].nil? ? '' : "parts/#{filename}.txt"
  end

  def self.subparts(path)
    parts = []
    File.open(path) do |file|
      rows = file.read.chomp.split("\n")
      rows.each do |i|
        item = i.split(',')
        parts << {:name => item[0], :mass => item[1].nil? ? 0 : item[1]}
      end
    end
    parts
  end

end