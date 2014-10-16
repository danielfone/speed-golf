# Like ActiveSupport strip_heredoc, "unindents" a multiline strip
#
# ~2x improvement available

require_relative '../micro_bench'

module StripHeredoc
  module_function

  def unindent(string)
    indent = string.split("\n").select {|line| !line.strip.empty? }.map {|line| line.index(/[^\s]/) }.compact.min || 0
    string.gsub(/^[[:blank:]]{#{indent}}/, '')
  end

end

TEXT = <<EOF
   See, the interesting thing about this text
     is that while it seems like the first line defines an indent
       it's actually the last line which has the smallest indent

    there are also some blank lines
  The End.
EOF

b = MicroBench.new StripHeredoc, TEXT*10, {
  "\tabc\n\tabc"            => "abc\nabc",
  "x"                       => "x",
  "  foo\n    bar\n  baz\n" => "foo\n  bar\nbaz\n",
}

b.check :unindent
