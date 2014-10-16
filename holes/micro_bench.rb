require 'benchmark/ips'

class MicroBench < Struct.new(:object, :input, :values)
  ANSI_GREEN = 32
  ANSI_RED   = 31

  def initialize(*args)
    super
    @pass_count = 0
    @fail_count = 0
  end

  def check(*args)
    opts = args.last.is_a?(Hash) ? args.pop : {}
    puts "Testing #{args.inspect}... "
    args.each { |m| check_method m }
    if passed?
      puts_color ANSI_GREEN, "all good."
      benchmark args, opts
    end
  end

  def check_method(method)
    values.each { |input, expected| check_result method, input, expected }
  end

  def passed?
    @fail_count == 0
  end

  def benchmark(methods, opts={})
    opts[:time]   ||= 0.5
    opts[:warmup] ||= 0.1

    Benchmark.ips opts[:time], opts[:warmup] do |x|
      methods.each do |m|
        x.report(m.to_s) { object.public_send m, input }
      end
      x.compare!
    end
  end

private

  def check_result(method, input, expected)
    actual = object.public_send method, input
    if actual != expected
      fail "[#{method}] Expected #{input.inspect} => #{expected.inspect}: got #{actual.inspect}"
    end
  end

  def fail(message)
    @fail_count += 1
    puts_color ANSI_RED, message
  end

  def puts_color(color_code, message)
    puts "\e[0;#{color_code}m" << message << "\e[0m"
  end
end
