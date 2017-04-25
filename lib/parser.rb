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
		root = program
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
		if token_type == @current_token.type
			@current_token = @lexer.get_next_token
		else
			error(token_type)
		end
	end

	# Error method, called when parsing fails
	def error(token_type)
		raise "Unexpected token in syntax #{@current_token.type} (Got #{token_type})"
	end

	# Parentesies error method, raised when parentesies aren't closed
	def par_error
		raise 'Parentesies not closed'
	end
	
	#
	# A BEGIN END block for declaring variables
	# block: declarations compound_statement
	#
	def block
		declaration_nodes = declarations
		compound_statement_node = compound_statement
		Block.new(declaration_nodes, compound_statement_node)
	end
	
	#
	# The variable declarations
	# declarations : VAR ( variable_declarations SEMI )+
	#              | empty
	#
	def declarations
		declarations = []
		if @current_token.type == Token::VAR
			eat(Token::VAR)
			while @current_token.type == Token::ID
				var_decl = variable_declaration
				declarations.push(*var_decl)
				eat(Token::SEMI)
			end
		end
		declarations
	end
	
	#
	# The variable declaration
	# variable_declaration : ID (COMMA ID)* COLON type_spec
	#
	def variable_declaration
		var_nodes = [Var.new(@current_token)]
		eat(Token::ID)
		
		while @current_token.type == Token::COMMA
			eat(Token::COMMA)
			var_nodes << Var.new(@current_token)
			eat(Token::ID)
		end
		
		eat(Token::COLON)
		
		type_node = type_spec
		var_declarations = []
		var_nodes.each do |var_node|
			var_declarations << VarDecl.new(var_node, type_node)
		end
		var_declarations
	end
	
	#
	# Variable types
	# type_spec : INTEGER,
	# 					| REAL
	#
	def type_spec
		token = @current_token
		if @current_token.type == Token::INTEGER
			eat(Token::INTEGER)
		else
			eat(Token::REAL)
		end
		Type.new(token)
	end
	
	#
	# Entry point for Pascal program
	# program: PROGRAM variable SEMI block DOT
	#
	def program
		eat(Token::PROGRAM)
		var_node = variable
		prog_name = var_node.value
		eat(Token::SEMI)
		block_node = block
		program_node = Program.new(prog_name, block_node)
		eat(Token::DOT)
		program_node
	end
	
	#
	# A block between BEGIN and END
	# compound_statement: BEGIN statement_list END
	#
	def compound_statement
		eat(Token::BEGIN_PAS)
		nodes = statement_list()
		eat(Token::END_PAS)

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
		error(@current_token) if @current_token.type == Token::ID

		results
	end

	#
	# statement: compound_statement | assignment_statement | empty
	#
	def statement
  	case @current_token.type
  	when Token::BEGIN_PAS
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
  	eat(Token::ASSIGN)
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
	# term: factor((mul|div|float_div) factor) *
	#
	def term
		node = factor()

		while [Token::INTEGER_DIV, Token::FLOAT_DIV, Token::MUL].include? @current_token.type 
			token = @current_token
			case @current_token.type
			when Token::INTEGER_DIV 
				eat(Token::INTEGER_DIV)
			when Token::MUL 
				eat(Token::MUL)
			when Token::FLOAT_DIV
				eat(Token::FLOAT_DIV)
			end

			node = BinOp.new(node, token, factor() )
		end
		node
	end

	#
	# Used to parse variables and numbers
	# factor: PLUS factor
	#         | MINUS factor
	#         | INTEGER_CONST
	#         | REAL_CONST
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
		when Token::INTEGER_CONST
			eat(Token::INTEGER_CONST)
			return Num.new(token)
		when Token::REAL_CONST
			eat(Token::REAL_CONST)
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