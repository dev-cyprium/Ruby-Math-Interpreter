require_relative "token"
#
# String helper methods used
#
class String
	def is_digit?
		self =~ /\d/
	end

	def is_space?
		self =~ /\s/
	end

	def is_alnum?
		self =~ /\w/
	end

	def is_letter?
		not(self =~ /\d/)
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

			# Numeric tokekn
			return Token.new(Token::INTEGER, integer) if @current_char.is_digit? 

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
				return Token.new(Token::DIV, "/")
			when "("
				advance
				return Token.new(Token::LPARENT, '(')
			when ")"
				advance
				return Token.new(Token::RPARENT, ')')
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

		token = Token::RESERVED_KEYWORDS[result]
		token = Token.new(result, Token::ID) if token.nil?
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
	def integer
		result = ''
		while not(@current_char == nil) and @current_char.is_digit?
			result += @current_char
			advance
		end
		raise 'Number too big Exception' if result.length > 15
		result.to_i
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