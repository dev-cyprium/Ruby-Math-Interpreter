require_relative 'interpreter'
require_relative 'memory'

class SymbolTableBuilder < NodeVisitor 
	attr_reader :symtab
	
	def initialize
		@symtab = SymbolTable.new
	end
	
	def visit_Block(node)
		node.declarations.each do |declaration|
			self.visit(declaration)
		end
		self.visit(node.compound_statement)
	end
	
	def visit_Program(node)
		self.visit(node.block)
	end
	
	def visit_BinOp(node)
		self.visit(node.left)
		self.visit(node.right)
	end
	
	def visit_Num(node)
	end
	
	def visit_UnaryOp(node)
		self.visit(node.expr)
	end
	
	def visit_Compound(node)
		node.children.each do |child|
			self.visit(child)
		end
	end
	
	def visit_NoOp(node)
	end
	
	def visit_VarDecl(node)
		type_name = node.type_node.value
		type_symbol = @symtab.lookup(type_name)
		var_name = node.var_node.value
		var_symbol = VarSymbol.new(var_name, type_symbol)
		@symtab.define(var_symbol)
	end
	
	def visit_Assign(node)
		var_name   = node.left.value
		var_symbol = @symtab.lookup(var_name)
		raise "Undefined variable #{var_name}." if var_symbol.nil?
		self.visit(node.right)
	end
	
	def visit_Var(node)
		var_name = node.value
		var_symbol = @symtab.lookup(var_name)
		
		raise "Undefined variable #{var_name}" if var_symbol.nil?
	end
end