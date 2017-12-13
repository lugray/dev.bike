#!/usr/bin/env ruby

require 'erb'

color = ENV['REQUEST_URI'].gsub(%r{.*/}, '')
if color !~ /^[0-9a-f]{6}$/
  puts "Status: 404 Not Found"
  puts "Content-type: text/plain"
  puts ""
  puts "Not Found"
  exit
end
puts "Content-type: image/png"
puts ""

template = File.read(File.expand_path("shed.svg.erb", File.dirname(__FILE__)))
output_svg = File.expand_path("#{color}.svg", File.dirname(__FILE__))
output_png = File.expand_path("#{color}.png", File.dirname(__FILE__))

File.write(output_svg, ERB.new(template).result(binding))

`convert #{output_svg} #{output_png}`
`rm #{output_svg}`
exec('cat', output_png)
