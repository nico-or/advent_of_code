require "forwardable"

class RopeNode
  attr_reader :position

  extend Forwardable

  def_delegators :@position, :x, :y, :distance
end
