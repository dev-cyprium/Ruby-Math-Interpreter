# The Symbol table
class SymbolTable
	def initialize
		@symbols = {}
		init_builtins()
	end	
	
	def define(symb)
		puts "Defined: #{symb}"
		@symbols[ symb.name ] = symb
	end
	
	def lookup(name)
		puts "Lookup: #{name}"
		symbol = @symbols[ name ]
	end
	
	def to_s
		buffer = ''
		@symbols.each do |key, value|
			buffer += "#{key}: #{value} \n"
		end
		buffer
	end
	
	def inspect
		to_s
	end
	
	private
		def init_builtins
			self.define(BuiltinTypeSymbol.new('INTEGER'))
			self.define(BuiltinTypeSymbol.new('REAL'))
		end
end


# All the symbol types
class PascalSymbol
	attr_reader :name, :type
	
	def initialize(name, type=nil)
		@name = name
		@type = type
	end
end

class BuiltinTypeSymbol < PascalSymbol
	def initialize(name)
		super(name)
	end
	
	def to_s
		@name
	end
	
	def inspect
		to_s
	end 
end

class VarSymbol < PascalSymbol
	def initialize(name, type)
		super(name, type)
	end
	
	def to_s
		"<#{name}:#{type}>"
	end
	
	def inspect
		to_s
	end
end	