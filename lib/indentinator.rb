class String
  def -(other)
    self.index(other) == 0 ? self[other.size..self.size] : nil
  end
end

module Indentinator

def indent_amount(lines)
  curr = ''
  diffs = {}
  # loop through the lines and count each indent difference
  # between prev and current line in `diffs`
  lines.each_with_index do |line, idx|
    whites = line.match(/^([ \t]*)/)[0]
    diff = whites - curr
    if @very_verbose
      puts "#{'%- 5d' % (idx + 1)}: #{diff.size}" if diff
    end
    if diff and diff.size > 0
      diffs[diff] ||= 0
      diffs[diff] = diffs[diff] + 1
    end
    curr = whites
  end
  # sort and pick the one w highest frequency
  if diffs.size > 0
    sorted = diffs.sort{|a, b| b[1] - a[1]}
    if @verbose
      puts sorted.map{|p| ('%- 5d=> ' % p[0].size) + p[1].to_s}.join("\n")
    end
    sorted[0][0]
  else
    ''
  end
end

def convert_indentation(text, from, to)
  convert_lines(text.split("\n"), from, to).join("\n")
end

def convert_lines(lines, from, to)
  indents = [] # indentation stack
  # loop through and convert line by line
  lines.map do |line|
    next line if line.strip.empty?
    m = line.match(/^([ \t]*)(.*)$/)
    whites = m[1]
    rest = m[2]
    diff = whites - indents.join
    if diff.nil?
      # no match indent, could be a de-indent or a different indent pattern
      # find longest matching indent in stack, and pop till that point
      indents.pop
      while indents.size > 0 and diff.nil?
        indents.pop
        diff = whites - indents.join
      end
    end
    indents.push(diff)
    indents
      .map{|i| i ? i.gsub("\t", to) : i }
      .map{|i| i == from ? to : i }.join + rest
  end
end

end

