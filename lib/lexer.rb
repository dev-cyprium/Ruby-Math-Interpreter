require_relative "token"
#
# String helper methods used
# TODO: Add test cases for helper methods
class String
	def is_digit?
		( self =~ /\d/ ) == 0
	end

	def is_space?
		( self =~ /\s/ ) == 0
	end

	def is_alnum?
		( self =~ /\w/ ) == 0
	end

	def is_letter?
		self =~ /[a-zA-Z]/
	end
end

#
# Class used to tokenize the string intro token stream
#
class Lexer
	# Read the string input
	attr_reader :text
	
	# The lexer needs a referance to an input text
	def initialize(text)
		@text = text
		@pos = 0
		@current_char = text[0]
	end

	# Returns the next token in the string
	def get_next_token
		while not(@current_char == nil)
			# Skip whitespace
			if @current_char.is_space?
				skip_whitespace
				next
			end

			# Text token Variable/Keyword
			return _id if @current_char.is_letter?

			# Numeric token
			return number if @current_char.is_digit? 

			# Asignment character
			if @current_char == ':' and peek() == '='
				advance 
				advance
				return Token.new(Token::ASSIGN, ':=') 
			end

			# Operation cases
			# Advance the current character, and generate a token
			case @current_char
			when '.'
				advance
				return Token.new(Token::DOT, '.')
			when ';'
				advance
				return Token.new(Token::SEMI, ';')
			when '+'
				advance
				return Token.new(Token::PLUS, '+')
			when '-'
				advance
				return Token.new(Token::MINUS, '-')
			when '*'
				advance
				return Token.new(Token::MUL, '*')
			when "/"
				advance
				return Token.new(Token::FLOAT_DIV, "/")
			when "("
				advance
				return Token.new(Token::LPARENT, '(')
			when ")"
				advance
				return Token.new(Token::RPARENT, ')')
			when ","
				advance
				return Token.new(Token::COMMA, ',')
			when ":"
				advance
				return Token.new(Token::COLON, ':')
			when "{"
				comment
				next
			end
			
			# No match found, raise an error
			error
		end
		# End of file is reached, token should be EOF
		return Token.new(Token::EOF, nil)
	end

	private
	# Handle identifiers and reserver keywords
	def _id
		result = ''
		while not @current_char.nil? and @current_char.is_alnum?
			result += @current_char
			advance
		end

		result.downcase!

		# Returns the token with the given keyword
		token = Token::RESERVED_KEYWORDS[result]
		# If the keyword dosn't exist, then return a token with the variable name
		token = Token.new(Token::ID, result) if token.nil?
		token
	end

	# Looks in the position of the next token
	def peek
		peek_pos = @pos + 1
		if peek_pos > @text.length - 1
			return nil
		else
			return @text[peek_pos]
		end
	end

	# Moves the pointer to the next character
	def advance
		@pos += 1
		if @pos > @text.length - 1
			@current_char = nil
		else
			@current_char = @text[@pos]
		end
	end

	# Gather all the grouped digits
	def number
		result = ''
		while not(@current_char == nil) and @current_char.is_digit?
			result += @current_char
			advance
		end
		raise 'Number too big Exception' if result.length > 15
		
		if @current_char == '.'
			result += @current_char
			advance
			while not(@current_char == nil) and @current_char.is_digit?
				result += @current_char
				advance
			end		
			token = Token.new(Token::REAL_CONST, result.to_f )	
		else 
			token = Token.new(Token::INTEGER_CONST, result.to_i)
		end
	end
	
	# Skips parsing of a comment
	def comment
		while not(@current_char == nil) and @current_char != '}'
			advance
		end
		advance
	end
	
	# Advance over all the whitespace characters
	def skip_whitespace
		while not(@current_char == nil) and @current_char.is_space?
			advance
		end
	end

	# Unknown token error
	def error
		raise "Unknown token Exception"
	end
end