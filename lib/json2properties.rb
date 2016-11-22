require 'json'
require 'java-properties'

class Json2properties
	VERSION = '0.0.1'
	SEPARATOR = '.'

	def initialize
		@prefix = ''
		@ret = {}
	end

	def convert_file(src, dest)
		JavaProperties.write(json2kv(File.read(src)), dest)
	end

	def json2kv(json)
		data = JSON.parse(json)
		process(data)
		@ret
	end

	private

	def process(data, prefix='')
		if data.is_a?(Array)
			data.each_index do |k|
				v = data[k]
				key = prefix.empty? ? k : prefix+SEPARATOR+k.to_s
				process(v, key)
			end
		elsif data.is_a?(Hash)
			data.each_pair do |k,v|
				key = prefix.empty? ? k : prefix+SEPARATOR+k.to_s
				process(v, key)
			end
		else
			@ret[prefix] = data
		end
	end

end
