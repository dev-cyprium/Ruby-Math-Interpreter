#
# Abstract class used as 
# a helper to visit nodes
#
class NodeVisitor
	def visit(node)
		method_name = "visit_" + node.class.name
		m = self.method(method_name.to_sym)
		return m.call(node)
	end
end

#
# Class used to interpret AST
# feed in the AST ( Abstract syntax tree you want to calculate )
class Interpreter < NodeVisitor
	
	def initialize(parser)
		@parser = parser
	end

	def visit_BinOp(node)
		case node.op.type
		when Token::PLUS
		when Token::MINUS
		when Token::MUL
		when Token::DIV
		end
	end

	def visit_Num(node)
		return node.value
	end
end