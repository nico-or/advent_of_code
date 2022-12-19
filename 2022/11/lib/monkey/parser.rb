module Parser

  # Example operation strings
  #   Operation: new = old * 19
  #   Operation: new = old + 6
  #   Operation: new = old * old
  def operation(string)
    num = find_integer(string)
    case string
    when /new = old \+ \d+/
      ->(x) { x + num }
    when /new = old \* \d+/
      ->(x) { x * num }
    when /new = old \* old/
      ->(x) { x * x }
    end
  end

  def find_integer(string)
    find_all_integers(string).first
  end

  def find_all_integers(string)
    string.scan(/\d+/).map(&:to_i)
  end
end
