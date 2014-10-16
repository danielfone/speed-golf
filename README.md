Setup
=====

    $ bundle
    Using benchmark-ips 2.0.0
    Using ruby-prof 0.15.1
    Using bundler 1.7.3
    Your bundle is complete!
    Use `bundle show [gemname]` to see where a bundled gem is installed.

Running
=======

    $ ruby holes/0/locale.rb

Profiling
=========

Before you profile, you might want to target your profiling and prevent the full benchmark from running.

    ```diff
     TEXT = <<EOF
        See, the interesting thing about this text
          is that while it seems like the first line defines an indent
            it's actually the last line which has the smallest indent

         there are also some blank lines
       The End.
     EOF

    +100.times { StripHeredoc.unindent TEXT }
    +exit
    +
     b = MicroBench.new StripHeredoc, TEXT*10, {
       "\tabc\n\tabc"            => "abc\nabc",
       "x"                       => "x",
       "  foo\n    bar\n  baz\n" => "foo\n  bar\nbaz\n",
     }

     b.check :unindent
    ```

Then you can run the profiler. I recommend the `call_stack` output

    $ ruby-prof -p call_stack -f profiles/locale.html holes/0/locale.rb
    $ open profiles/locale.html
