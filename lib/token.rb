# Class holding all the token information
class Token
	INTEGER = "INT"
	PLUS = "PLU"
	MINUS = "MIN"
	MUL = "MUL"
	DIV = "DIV"
	EOF = "EOF"
	LPARENT = "("
	RPARENT = ")"
	FACT = "!"

	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end
end