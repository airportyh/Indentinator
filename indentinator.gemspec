Gem::Specification.new do |s| 
  s.name = "Indentinator"
  s.version = "0.0.1"
  s.author = "Toby Ho"
  s.email = "airportyh@gmail.com"
  s.homepage = "http://tobyho.com"
  s.bindir = 'bin'
  s.executables = ['indentinator']
  s.platform = Gem::Platform::RUBY
  s.summary = "Indentinator is a Ruby script that inspects and changes the indentation in
  your source files."
  s.files = ['lib/indentinator.rb', 'bin/indentinator']
  s.require_path = "lib"
  s.test_files = ['test/tests.rb']
end