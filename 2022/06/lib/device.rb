class Device
  attr_accessor :message

  def initialize(message = "")
    @message = message
  end

  def packet_marker
    first_unique(message, 4)
  end

  def message_marker
    first_unique(message, 14)
  end

  private

  def first_unique(string, count)
    string.length.times do |idx|
      return idx + count if string.slice(idx, count).chars.uniq.count.eql?(count)
    end
  end
end
