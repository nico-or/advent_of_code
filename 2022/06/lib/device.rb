class Device
  def self.marker(datastream)
    datastream.length.times do |idx|
      return idx + 4 if datastream[idx..idx + 3].chars.uniq.count.eql? 4
    end
  end
end
