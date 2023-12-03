lines = STDIN.readlines.map(&:strip).reject(&:empty?)

MAX = {"red" => 12, "green" => 13, "blue" => 14}

def set_to_h(set)
    set.split(",").
        map(&:strip).
        map{|s| s.match /(?<count>\d+) (?<colour>(red|green|blue))/}.
        inject({}){|acc,m| acc[m[:colour]] = m[:count].to_i; acc}
end

first_star =
    lines.
        map {|l| l.match /Game (?<id>\d+): (?<data>.*)/ }.
        map {|m| {id: m[:id].to_i, sets: m[:data].split(";").map(&:strip)}}.
        map {|s| {id: s[:id], sets: s[:sets].map{|set| set_to_h(set) }}}.
        select {|s| s[:sets].all? {|set| set.all?{|colour, count| count <= MAX[colour] }}}.
        sum {|s| s[:id]}

puts "First star: #{first_star}"
