Indentinator!
=============

Indentinator is a Ruby script that inspects and changes the indentation in
your source files. _Indent your code the way you want._

Install
=======

Assuming you have ruby and rubygem installed, you can

	gem install Indentinator
	
to install it.

Usage 
=====
  
    indentinator [-c INDENT_AMOUNT] <file> [<file2>...]
  
Options
-------
  
    -c INDENT_AMOUNT
          Modify the indentation amount to INDENT_AMOUNT. The value is either
          a number - in which case it indicates the number of spaces to use; 
          or TAB - which indicates to use tabs.
  
    -a AMOUNT
          Tell it the original AMOUNT of indentation to use 
          when converting the file's indentation. 
          Normally, this value is inferred by looking at the input.
          This option takes the same values as -c.
  
    -i    Read input from stdin. This will ignore any file arguments.
  
    -r    Replace the original file. Please back up your file or make sure you
          are using version control. Indentinator is not responsible for
          any damages; it just indents.
  
    -v    Verbose output

    -V    Very verbose output

Examples
========

Using `indentinator` with a file argument will tell you what amount of indentation the file uses.

	$ indentinator lib/myapp.rb 
	lib/myapp.rb uses 2 spaces.
	
Using with the `-c` option will convert the file to the desired indentation amount, and print the result to `stdout`.

	$ indentinator -c 4 lib/myapp.rb
	
The `-r` option will overwrite the original file with the output.

	$ indentinator -rc 4 lib/myapp.rb
	
Make sure you have the file backed up or source controlled first! I am not
responsible for any damages.

If you want to read the input from `stdin`, use the -i option

	$ cat lib/myapp.rb | indentinator -ic 4
	
If you use a mixture of indentation sizes in your source file, indentinator may guess wrong, which will in turn affect the conversion output. To tell it
explicitly the original indentation amount for it to use during the conversion 
process use the `-a` option

	$ indentinator -a 4 -c lib/myapp.rb
	
Totally Use it Inside TextMate and Stuff
========================================

If you copied a snippet of code from the internets, and it uses a different
indentation then you, it will be helpful to use indentinator from within TextMate. To do this, follow these steps:

1. Go to `TextMate->Preferences...->Advanced->Shell Variables`, and make sure
   the `PATH` variable contains the location of the `indentinator` executable.
2. Paste the code snippet into TextMate, select that snippet and hit Command-Option-R. 
3. In the `Command:` text field type in the indentinator command to use, for
   example `indentinator -ic 2`, which will take the selected text as input
   (from `stdin`) and output it with an indentation of 2 spaces.
4. Click `Execute`.
	
Todo
====

- preserve multiline string literals in languages that support them