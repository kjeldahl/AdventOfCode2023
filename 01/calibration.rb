lines = STDIN.readlines.map(&:strip).reject(&:empty?)

def digit?(str, digits=(0..9).to_a.map(&:to_s))
    digits.include?(str)
end

first_star =
    lines.
        map {|l| l.split("").select{|a| digit?(a)} }.
        map{|n| n.empty? ? 0 : (n.first + n.last).to_i }.
        sum
puts "First star: #{first_star}"

digit_words = %w[one two three four five six seven eight nine]
digits = (0..9).to_a.map(&:to_s) + digit_words

def digit_at(str, i, digits=(0..9).to_a.map(&:to_s))
    digits.find {|d| str[i..-1].index(d) == 0 }
end

def value(s, digit_words=[])
  digit_words.index(s)&.+(1)&.to_s || s
end

second_star =
    lines.
        map {|l| (0...l.size).map{|i| digit_at(l, i, digits)}.compact }.
        each_with_index.
        map{|n, i| val = (value(n.first, digit_words) + value(n.last, digit_words)).to_i; puts "#{i}: #{n.inspect} => #{val}"; val }.
        sum
puts "Second star: #{second_star}"
