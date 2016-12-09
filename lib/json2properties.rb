require 'json'
require 'java-properties'
require 'active_support'
require 'active_support/core_ext/hash'

class String
	def is_i?
		/\A\d+\z/ === self
	end

	def is_numeric?
		return true if self.is_i?
		true if Float(self) rescue false
	end

	def is_numeric_leading_zero?
		self[0].eql?("0") && self.length > 1
	end

end

class Json2properties
	VERSION = '0.0.3'
	SEPARATOR = '.'

	def initialize
		reset_state
	end

	# json => properites
	def convert_file(src, dest)
		JavaProperties.write(json2kv(File.read(src)), dest)
	end

	# properites => json
	def unconvert_file(src, dest)
		kv = JavaProperties.load(src)
		File.write(dest, kv2json(kv))
	end

	# json string => flat k-v hash
	def json2kv(json)
		reset_state
		data = JSON.parse(json)
		process_json_hash(data)
		@ret
	end

	# flat k-v hash => json string
	def kv2json(kv)
		reset_state
		kv.stringify_keys!
		ret = {}
		kv.each_pair do |k,v|
			tmp = ret
			parts = k.split(SEPARATOR)
			parts.each_index do |i|
				part = parts[i]
				next_part = parts[i+1]

				part = part.to_i if ( part.is_i? && !part.is_numeric_leading_zero? )
				if tmp[part].nil?
					if next_part.nil?
						tmp[part] = fix_type(v)
					elsif next_part.is_i? && !next_part.is_numeric_leading_zero?
						tmp[part] = []
					else
						tmp[part] = {}
					end
				end
				tmp = tmp[part]
			end
		end
		JSON.pretty_generate(ret)
	end

	private

	def fix_type(v)
		return v if v.is_numeric_leading_zero?
		return v.to_i if v.is_i?
		return v.to_f if v.is_numeric?
		return true if v == "true"
		return false if v == "false"
		v
	end

	def reset_state
		@prefix = ''
		@ret = {}
	end

	def process_json_hash(data, prefix='')
		if data.is_a?(Array)
			data.each_index do |k|
				v = data[k]
				key = prefix.empty? ? k : prefix+SEPARATOR+k.to_s
				process_json_hash(v, key)
			end
		elsif data.is_a?(Hash)
			data.each_pair do |k,v|
				key = prefix.empty? ? k : prefix+SEPARATOR+k.to_s
				process_json_hash(v, key)
			end
		else
			@ret[prefix] = data
		end
	end

end
