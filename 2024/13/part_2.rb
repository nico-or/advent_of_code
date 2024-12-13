# frozen_string_literal: true

FILENAME = ARGV[0]

input = File.read(FILENAME)

values = input.split("\n\n")
              .map { _1.scan(/\d+/).map(&:to_i) }

values.reduce(0) do |acc, arr|
  xa, ya, xb, yb, xt, yt = arr
  xt += 10_000_000_000_000
  yt += 10_000_000_000_000
  nb = (xa * yt - ya * xt) / (xa * yb - ya * xb)
  na = (xt - xb * nb) / xa
  sx = na * xa + nb * xb == xt
  sy = na * ya + nb * yb == yt
  out = sx && sy ? 3 * na + nb : 0
  acc + out
end.then { p _1 }
