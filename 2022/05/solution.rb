require_relative "./lib/parser"
require_relative "./lib/stack"
require_relative "./lib/collection"
require_relative "./lib/instruction"

filename = "./input.txt"

collection = Collection.from_file(filename)
parser = Parser.new(filename)

parser.instructions.each { collection.move!(_1) }

puts collection.code
