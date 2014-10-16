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

Before you profile, you might want to ...

    $ ruby-prof -p call_stack -f profiles/locale.html holes/0/locale.rb
    $ open profiles/locale.html
