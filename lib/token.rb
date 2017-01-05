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
	ASSIGN = "ASSIGN"
	BEGIN_PAS = "BEGIN"
	END_PAS = "END"
	SEMI = "SEMI"
	DOT = "DOT"

	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end


	# Begin/End keywords
	RESERVED_KEYWORDS = {
		begin: Token.new("BEGIN", "BEGIN"),
		end: Token.new("END", "END")
	}
end