# Randomly return half the numbers under the provided limit
# e.g.
#   sample_half(10) => [1,3,4,5,8]
#   sample_half(4) => [2,3]
#
# Things that don't matter:
#   - order
#   - inclusive/exclusive of 0 and the limit
#
# Things that do matter:
#   - passing the test
#   - returning the right number of elements
#   - all returned elements are UNIQUE
#   - being random (no, you can't test this. I'll be checking any winning algorithms)
#
# One rule: this is a BYO entropy challenge,
#           you may not use #sample or #shuffle
#
# ~30x improvement available

require_relative '../micro_bench'

module Sample
  module_function

  def sample_half(limit)
    count = limit/2
    population = (1..limit).to_a
    sample = []
    count.times do |i|
      random_index = rand population.size
      sample << population.delete_at(random_index)
    end
    sample
  end

end

TEST_METHODS = [
  :sample_half,
  # Add your methods in here...
]

# Unconvential tests because the output is random
TEST_METHODS.each do |method|
  limit = 20
  count = 10

  result = Sample.public_send method, limit
  fail "[#{method}] returned #{result.class.name}, expected Array" unless result.is_a? Array

  uniq_count = result.uniq.count
  fail "[#{method}] returned #{uniq_count} uniq elements, expected #{count}" if uniq_count != count

  result.each do |n|
    fail "[#{method}] included #{n} which is above limit #{limit}" if n > limit
    fail "[#{method}] included #{n} which is less than 0" if n < 0
  end
end

b = MicroBench.new Sample, 100000, {}
b.check *TEST_METHODS
