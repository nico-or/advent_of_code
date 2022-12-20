require "json"

filename = ARGV[0] || "sample.txt"

input = File.readlines(filename, chomp: true)

structures = input.map do |line|
  line.split(" -> ").map do |section|
    JSON.parse("[#{section}]")
  end
end

# rock structure dimensions
$min_col, $max_col = structures.flatten(1).map { _1[0] }.minmax
$min_row, $max_row = structures.flatten(1).map { _1[1] }.minmax

$sand_col = 500

# add floor
floor_row = $max_row + 2
width = $max_row + 3 # a sand block can only fo as far as sand_col +/- max_row
structures << [[$sand_col - width, floor_row],[$sand_col + width, floor_row],]

# rock structure dimensions
$min_col, $max_col = structures.flatten(1).map { _1[0] }.minmax
$min_row, $max_row = structures.flatten(1).map { _1[1] }.minmax

$map = Hash.new

def print_map()
  width = [$sand_col - $min_col, $max_col - $sand_col].max + 5 
  columns = Range.new($sand_col - width, $sand_col + width)
  0.upto($max_row) do |row|
    foo = "%3d " % row
    cols = columns.map { |col| $map[[row, col]] || "." }.join
    puts "#{foo} #{cols}"
  end
end

# populate map with rock structures aka #
structures.each do |section|
  section.each_cons(2) do |from, to|
    from_col, from_row = from
    to_col, to_row = to

    # vertical line
    if from_col.eql? to_col
      range = from_row < to_row ? Range.new(from_row, to_row) : Range.new(to_row, from_row)
      range.each { |row| $map[[row, from_col]] = "#" }
    end

    # horizontal line
    if from_row.eql? to_row
      range = from_col < to_col ? Range.new(from_col, to_col) : Range.new(to_col, from_col)
      range.each { |col| $map[[from_row, col]] = "#" }
    end
  end
end

def drop_sand(row, col)
  return false if row > $max_row
  return false if $map[[row, col]].eql? 'o'
  
  next_level = [
    $map[[row + 1, col - 1]],
    $map[[row + 1, col + 0]],
    $map[[row + 1, col + 1]],
  ]
  
  case next_level
  in [String, String, String]
    $map[[row,col]] = 'o'
    true
  in [_,nil,_]
    drop_sand(row+1,col)
  in [nil,String,_]
    drop_sand(row + 1, col-1)
  in [String,String,nil]
    drop_sand(row + 1, col+1)
  end
end

counter = 0
counter += 1 while drop_sand(0,$sand_col)

print_map

puts "sand count: #{counter}"
