require_relative 'token'
require_relative 'node'
require_relative 'lexer'
#
# Parser class for parsing the AST
# Creates the tree of nodes, that the interpreter can exectute
#
class Parser
	def initialize(lexer)
		@lexer = lexer

		@current_token = lexer.get_next_token
	end

	def parse
		par_error if not(parentes_closed?)
		root = expr
		error if @current_token.type != Token::EOF
		return root
	end

	# Private methods used to parse the math expression
	private

	# Checks to see if brackets are closed in the input
	def parentes_closed?
		input = @lexer.text
		lparen_count = 0
		rparen_count = 0
		input.each_char do |char|
			lparen_count+=1 if char == '('
			rparen_count+=1 if char == ')'
		end
		lparen_count == rparen_count
	end

	# Consumes the token, and gets the next one
	def eat(token_type)
		puts "Eaten #{token_type}"
		if token_type == @current_token.type
			@current_token = @lexer.get_next_token
		else
			error
		end
	end

	# Error method, called when parsing fails
	def error
		raise "Unexpected token in syntax"
	end

	# Parentesies error method, raised when parentesies aren't closed
	def par_error
		raise 'Parentesies not closed'
	end

	#
	# Entry point for Pascal program
	# program: compound_statement DOT
	#
	def program
		node = compound_statement()
		eat(Token::DOT)
		node
	end
	
	#
	# A block between BEGIN and END
	# compound_statement: BEGIN statement_list END
	#
	def compound_statement
		eat(Token::BEGIN)
		nodes = statements_list()
		eat(Token::END)

		root = Compound.new
		nodes.each do |node|
			root.children << node
		end

		root
	end

	#
	# List of statements
	# statement_list: statement | statement SEMI statement_list
	#
	def statement_list
		node = statement()

		results = [node]

		while @current_token.type == Token::SEMI
			eat(Token::SEMI)
			results << statement()
		end

		# Throw an error when SEMI is missing
		error() if @current_token.type == Token::ID

		results
	end

	#
	# statement: compound_statement | assignment_statement | empty
	#
	def statement
  	case @current_token.type
  	when Token::BEGIN
  		node = compound_statement()
  	when Token::ID
  		node = assignment_statement()
  	else
  		node = empty()
  	end
  	node
  end

  #
  # assignment_statement: variable ASSIGN expr
  #
  def assignment_statement
  	left = variable()
  	token = @current_token
  	eat(Token::ASIGN)
  	right = expr()
  	node = Assign.new(left, token, right)
  end

  #
  # variable: ID
  #
  def variable
  	node = Var.new(@current_token)
  	eat(Token::ID)
  	node
  end

  # Empty operation
  def empty
  	NoOp.new
  end



	# 
	# Expression method, the first method in the GRAMMAR
	# expr: term((plus|minus) term) *
	#
	def expr
		node = term()

		while [Token::PLUS, Token::MINUS].include? @current_token.type
			token = @current_token
			case @current_token.type
			when Token::PLUS
				eat(Token::PLUS)
			when Token::MINUS
				eat(Token::MINUS)
			end

			node = BinOp.new(node, token, term() )
		end
		node
	end

	#
	# Term method, the second method in the GRAMMAR
	# term: factor((mul|div) factor) *
	#
	def term
		node = factor()

		while [Token::DIV, Token::MUL].include? @current_token.type 
			token = @current_token
			case @current_token.type
			when Token::DIV 
				eat(Token::DIV)
			when Token::MUL 
				eat(Token::MUL)
			end

			node = BinOp.new(node, token, factor() )
		end
		node
	end

	#
	# Used to parse variables and numbers
	# factor: PLUS factor
	#         | MINUS factor
	#         | INTEGER
	#         | LPARENT expr RPAREN
	#         | variable
	#
	def factor
		token = @current_token
		case token.type
		when Token::PLUS
			eat(Token::PLUS)
			node = UnaryOp.new(token, factor())
			return node
		when Token::MINUS
			eat(Token::MINUS)
			node = UnaryOp.new(token, factor())
			return node
		when Token::INTEGER
			eat(Token::INTEGER)
			return Num.new(token)
		when Token::LPARENT
			eat(Token::LPARENT)
			node = expr()
			eat(Token::RPARENT)
			return node
		else
			node = variable()
		end
	end
end