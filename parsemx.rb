require 'open-uri'
require_relative 'twparser'
require_relative 'travel_warnings/app/models/travel_warning'

# parser = Twparser.new(File::read("TWs.xml"))
parser = Twparser.new(open(("https://travel.state.gov/_res/rss/TWs.xml")))
mxwarning = parser.get_mexico_warnings
puts mxwarning.intro
mxwarning.warnings.each do | warning |
  tw = TravelWarning.new(name: warning.region, fullname: warning.region_full_desc, detail: warning.warning)
  tw.save
  puts "Saved----"
  puts warning.region
  puts warning.region_full_desc
  puts warning.warning
end
