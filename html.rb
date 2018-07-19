require 'axlsx'
require 'erb'

merged = []
current = -1

str = File.read("combined.log")
str.each_line do |line|
  line.strip!
  next if line.empty?
  next if line.include?('selected') || line.include?('IN_GB')
  next if ['-','='].include? line[0]
  parts = line.split ' '
   if parts.size == 1 and line.start_with?('size')
	merged[current += 1] = {server: line.strip, data: {}}
    next
  elsif parts.size == 1 and parts = /^(?!.*size_).*$/
	merged[current += 1] = {name: line, data: {}}
    next
  end

  parts.each_cons(2) do |key, value|
    merged[current][:data][key] = value 
	end
end

@servers = []
line = {}
merged.each do |val|
  if val.key?(:server)
   unless line.empty?
@servers << line
     line = {}
   end
   line = {
     server_name:  val[:server],
     attributes: []
   }
   next
  end
  line[:attributes] << val
end
@servers << line

#puts @servers

view = File.open(("output.html"), "w+")
view.puts ERB.new(File.read("ola.html.erb")).result binding