# Return the nth fibonacci number
#
# ~300x improvement available
#
# Bonus points: increase n and see if different algorithms perform better

require_relative '../micro_bench'

module Fibonacci
  module_function

  def fibonacci(n)
    n <= 1 ? n : fibonacci(n-1) + fibonacci(n-2)
  end

end

b = MicroBench.new Fibonacci, 15, {
  1  => 1,
  2  => 1,
  3  => 2,
  4  => 3,
  10 => 55,
  15 => 610,
  20 => 6765,
}
b.check :fibonacci
