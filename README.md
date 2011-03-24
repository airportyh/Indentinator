Indentinator!
=============

Indentinator is a Ruby script that inspects and changes the indentation in
your source files.

Usage 
=====
  
    indentinator [-c INDENT_AMOUNT] <file> [<file2>...]
  
Options
-------
  
    -c    Modify the indentation amount to INDENT_AMOUNT
    -v    Verbose output
    -V    Very verbose output

Example
=======

Using `indentinator` with a file will tell you what amount of indentation the file uses.

	$ indentinator lib/indentinator.rb 
	lib/indentinator.rb uses 2 spaces.
	
Using with the `-c` option will convert the file to the desired indentation amount, and print the result to STDOUT. In the future, there will be an option to overwrite the original file.

	$ indentinator -c 4 lib/indentinator.rb
	
Todo
====

- support tabs
- preserve multiline string literals in languages that support them