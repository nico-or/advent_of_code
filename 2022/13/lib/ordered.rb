def ordered?(left, right)
  if [left, right].all? { _1.instance_of? Integer }
    return left.eql?(right) ? nil : left < right
  elsif [left, right].any? { _1.instance_of? Integer }
    left.instance_of?(Integer) ? ordered?([left], right) : ordered?(left, [right])
  elsif [left, right].all? { _1.instance_of? Array }
    output = ordered?(left.first, right.first)
    return output unless output.nil?
    return nil if [left, right].all?(&:empty?)
    return true if left.empty?
    return false if right.empty?

    ordered?(left[1..], right[1..])
  end
end
