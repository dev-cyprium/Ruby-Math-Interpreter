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
	ID = "ID"

	RESERVED_KEYWORDS = {
		"BEGIN": Token.new("BEGIN", "BEGIN"),
		"END": Token.new("END", "END")
	}

	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end
end