module Indentinator

def indent_amount(lines)
  curr = 0
  diffs = {}
  lines.each_with_index do |line, idx|
    spaces = line.match(/^( *)/)[0]
    diff = spaces.size - curr
    if @very_verbose
      puts "#{'%- 5d' % (idx + 1)}: #{diff}"
    end
    if diff > 0
      diffs[diff] ||= 0
      diffs[diff] = diffs[diff] + 1
    end
    curr = spaces.size
  end
  if diffs.size > 0
    sorted = diffs.sort{|a, b| b[1] - a[1]}
    if @verbose
      puts sorted.map{|p| ('%- 5d=> ' % p[0]) + p[1].to_s}.join("\n")
    end
    sorted[0][0]
  else
    0
  end
rescue ArgumentError
  # Probably a binary file
  nil
end

def convert_indentation(text, from, to)
  convert_lines(text.split("\n"), from, to).join("\n")
end

def convert_lines(lines, from, to)
  ratio = to.to_f / from
  curr_indent_org = 0
  curr_indent = 0
  lines.map do |line|
    if line.empty?
      line
    else
      m = line.match(/^( *)(.*)$/)
      spaces = m[1]
      rest = m[2]
      indent = spaces.size - curr_indent_org
      curr_indent_org = spaces.size
      if indent == from # standard indent
        curr_indent += (indent * ratio).to_i
      elsif indent > 0 # non-standard indent
        curr_indent += indent
      elsif indent == 0 # no indent
        
      else # de-indent
        # reset back to use original indentation
        curr_indent = (curr_indent_org * ratio).round
      end
      ' ' * curr_indent + rest
    end
  end
end

end

