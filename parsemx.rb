require 'open-uri'
require_relative 'twparser'

# parser = Twparser.new(File::read("TWs.xml"))
parser = Twparser.new(open(("https://travel.state.gov/_res/rss/TWs.xml")))
mxwarning = parser.get_mexico_warnings
puts mxwarning.intro
mxwarning.warnings.each do | warning |
  puts "----"
  puts warning.region
  puts warning.region_full_desc
  puts warning.warning
end
