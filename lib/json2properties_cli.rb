require_relative './json2properties'

class Json2propertiesCli

	def initialize(argv)
		@argv = argv
		@src = @argv[0] || ''
		@dest = @argv[1] || ''
	end

	def unconvert_file
		validate_argv('properties2json')
		Json2properties.new.unconvert_file(@src, @dest)
	end

	def convert_file
		validate_argv('json2properties')
		Json2properties.new.convert_file(@src, @dest)
	end

	private

	def validate_argv(mode)
		if @src.empty? || @dest.empty?
			STDERR.puts "Usage: #{mode} <SRC_FILE> <DEST_FILE>"
			exit 1
		end
		unless File.exists? @src
			STDERR.puts "Given source file doesn't exist: #{@src}"
			exit 1
		end
	end

end
