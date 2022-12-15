require_relative "filesystem/node"
require_relative "filesystem/file"
require_relative "filesystem/directory"
require_relative "filesystem/filesystem"

module Filesystem
  def self.instruction(instruction, filesystem)
    case instruction
    when /\$ cd .+/
      match = /\$ cd (.+)\n/.match(instruction)
      dirname = match[1]

      if dirname.eql? "/"
        filesystem.mkdir(dirname)
      else
        filesystem.cd(dirname)
      end
    when /dir .+/
      match = /dir (.+)\n/.match(instruction)
      dirname = match[1]
      filesystem.mkdir(dirname)
    when /\d+ .+/
      match = /(?'size'\d+) (?'name'.+)/.match(instruction)
      filesystem.touch(match["name"], match["size"].to_i)
    end
  end
end
