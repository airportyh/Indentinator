def indent_amount(lines)
  curr = 0
  diffs = {}
  lines.each_with_index do |line, idx|
    spaces = line.match(/^( *)(?=[^ ])/)[0]
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
  nil
end

def convert_indentation(text, from, to)
  convert_lines(text.split("\n"), from, to).join("\n")
end

def convert_lines(lines, from, to)
  diff = 0
  last_org_amount = 0
  ratio = to.to_f / from
  lines.map { |line|
    m = line.match(/^( *)(.*)$/)
    spaces = m[1]
    rest = m[2]
    amount = spaces.size
    indent = amount - last_org_amount
    last_org_amount = amount
    if indent == 0
      line
    elsif (indent > 0 and indent == from) or indent < 0
      new_amount = (amount * ratio).round
      diff = new_amount - amount
      spaces = ' ' * new_amount
      spaces + rest
    else
      # non-standard indentation amount, use the amount of
      # previous line
      new_amount = amount + diff
      spaces = ' ' * new_amount
      spaces + rest
    end
  }
end


