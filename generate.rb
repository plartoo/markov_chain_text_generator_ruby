require File.dirname(__FILE__) + '/lib/init'

unless ARGV[0]
  usage =<<EOF
  usage: #{File.basename(__FILE__)} <source file> [optional: seed word]
         to generate text using <source file> as the seed data

  Note: Default <seed word> is "Nearly"
EOF
  puts usage
  exit(1)
end

seed_file = ARGV[0]
seed_text = File.open(File.join(File.dirname(__FILE__), seed_file)) do |f|
  f.read
end

text_generator = TextGenerator.new
text_generator.seed(seed_text)
puts text_generator.generate("Nearly" || ARGV[1])
