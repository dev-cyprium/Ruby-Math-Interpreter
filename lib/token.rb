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
	COMMA = "COMMA"
	FLOAT_DIV = "FLOAT_DIV"
	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end


	# Begin/End keywords
	RESERVED_KEYWORDS = {
		"program" => Token.new("PROGRAM", "PROGRAM"),
		"var" 		=> Token.new("VAR", "VAR"),
		"div"			=> Token.new("INTEGER_DIV", "DIV"),
		"integer" => Token.new("INTEGER", "INTEGER"),
		"real"		=> Token.new("REAL", "REAL"),
		"begin" 	=> Token.new("BEGIN", "BEGIN"),
		"end" 		=> Token.new("END", "END")
	}
end