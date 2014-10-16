# Bigrams are pairs of words found in a text.
#
# This module returns a hash of the pairs and their frequencies.
#
# The text should be normalised, but punctuation will "stop" a bigram. e.g.
#
#   "Hello you how's it?" has 3 bigrams:
#        "hello you"
#        "you hows"
#        "hows it"
#
#   Whereas "Hello you, how's it?" has 2 bigrams:
#        "hello you"
#        "hows it"
#
# See the tests for futher examples
#
# ~2.5x improvement available

require_relative '../micro_bench'

module Bigrams
  module_function

  def parse(text)
    tally = {}
    prev_word = nil

    text.split.each do |word|

      word_starts_with_punctuation = word =~ /^[^\w\s]/
      prev_word_ends_with_punctuation = prev_word =~ /[^\w\s]$/

      break_for_punctuation = word_starts_with_punctuation || prev_word_ends_with_punctuation

      if prev_word && ! break_for_punctuation
        # Remove internal punctuation to create bigram
        bigram = [
          prev_word.downcase.gsub(/[^\w\s]/, ''),
          word.downcase.gsub(/[^\w\s]/, ''),
        ].join ' '

        # Increment our counter
        tally[bigram] = 0 unless tally.has_key? bigram
        tally[bigram] += 1
      end

      # Remember our this word for next time
      prev_word = word
    end
    tally
  end

end

corpus = File.read File.expand_path("../midsummer.txt", __FILE__)

b = MicroBench.new Bigrams, corpus, {

  "and then and then and then" => {
    "and then" => 3,
    "then and" => 2,
  },

  "Hello you, my name is hello you my" => {
    "hello you" => 2,
    "my name"   => 1,
    "name is"   => 1,
    "is hello"  => 1,
    "you my"    => 1,
  },

  "Hello you how's it?" => {
    "hello you" => 1,
    "you hows"  => 1,
    "hows it"   => 1,
  },

  "Hello you, how's it?" => {
    "hello you" => 1,
    "hows it"   => 1,
  },
}

b.check :parse, time: 2
