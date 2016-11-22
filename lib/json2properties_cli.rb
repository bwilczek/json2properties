require_relative './json2properties'

class Json2propertiesCli

	def initialize(argv)
		@argv = argv
		@src = @argv[0] || ''
		@dest = @argv[1] || ''
	end

	def run
		if @src.empty? || @dest.empty?
			STDERR.puts "Usage: json2properties <SRC_FILE> <DEST_FILE>"
			exit 1
		end
		unless File.exists? @src
			STDERR.puts "Given source file doesn't exist: #{@src}"
			exit 1
		end
		Json2properties.new.convert_file(@src, @dest)
	end

end
