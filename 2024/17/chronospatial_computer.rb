# frozen_string_literal: true

class ChronospatialComputer
  def self.from_string(string)
    reg_a, reg_b, reg_c, *instructions = string.scan(/\d+/).map(&:to_i)
    new(reg_a, reg_b, reg_c, instructions)
  end

  def initialize(reg_a, reg_b, reg_c, instructions)
    @reg_a = reg_a
    @reg_b = reg_b
    @reg_c = reg_c
    @instructions = instructions
    @pointer = 0
    @output = []
  end

  def halted?
    @pointer >= @instructions.length
  end

  def output
    @output.join(',')
  end

  def output!
    calculate! until halted?
    output
  end

  def calculate!
    raise 'computer halted' if halted?

    opcode = @instructions[@pointer]
    operand = @instructions[@pointer + 1]

    case opcode
    when 0 then adv(operand)
    when 1 then bxl(operand)
    when 2 then bst(operand)
    when 3 then jnz(operand)
    when 4 then bxc
    when 5 then out(operand)
    when 6 then bdv(operand)
    when 7 then cdv(operand)
    else raise ArgumentError, "invalid opcode: #{opcode}"
    end
    @pointer += 2
  end

  private

  def combo_operand(operand)
    if operand.between?(0, 3) then operand
    elsif operand.eql? 4 then @reg_a
    elsif operand.eql? 5 then @reg_b
    elsif operand.eql? 6 then @reg_c
    else
      raise ArgumentError, "invalid operand: #{operand}"
    end
  end

  def adv(operand)
    operand = combo_operand(operand)
    @reg_a = (@reg_a / 2**operand)
  end

  def bxl(operand)
    @reg_b ^= operand
  end

  def bst(operand)
    operand = combo_operand(operand)
    @reg_b = operand % 8
  end

  def jnz(operand)
    return if @reg_a.zero?

    @pointer = operand - 2
  end

  def bxc
    @reg_b ^= @reg_c
  end

  def out(operand)
    operand = combo_operand(operand)
    @output << operand % 8
  end

  def bdv(operand)
    operand = combo_operand(operand)
    @reg_b = (@reg_a / 2**operand)
  end

  def cdv(operand)
    operand = combo_operand(operand)
    @reg_c = (@reg_a / 2**operand)
  end
end
