class Token
	INTEGER_CONST = "INT"
	REAL_CONST = "REL"
	PLUS = "PLU"
	MINUS = "MIN"
	MUL = "MUL"
	INTEGER_DIV = "INTEGER_DIV"
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
	PROGRAM = "PROGRAM"
	VAR = "VAR"
	COLON = "COLUMN"
	INTEGER = "INTEGER"
	REAL = "REAL"
	attr_accessor :type, :value

	def initialize(type, value)
		@type = type
		@value = value
	end

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