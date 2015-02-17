require 'active_support/inflector'

class Hash
	def to_symbol
		new_hash = {}
		self.each do |k,v|
			k_symbol = k.to_symbol
			if v.class == Array
				new_hash[k_symbol] = Array.new
				if v[0].class == Hash
					name_class = k.singularize.camelize
					v.each do |tab|
						new_hash[k_symbol] << Object.const_get("RiotLolApi::Model::#{name_class}").new(tab.to_symbol)
					end
				else
					v.each do |tab|
						new_hash[k_symbol] << tab
					end
				end
			elsif v.class == Hash
				name_class = k.singularize.camelize
				new_hash[k_symbol] = Object.const_get("RiotLolApi::Model::#{name_class}").new(v.to_symbol)
			else
				new_hash[k_symbol] = v
			end
		end
		new_hash
	end
end
