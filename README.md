# About
Welcome to my Ruby Math interpreter project. The idea behind this project came to me when I was unable to finish
an exercise on some website. The exercise was to make a parser to handle some custom file format.
Atempting to learn parsers/interpreters I've written a fully-featured math interpreter in ruby that support
four basic math operations: *, +, -, /
This project is fully tested with RSpec, and you can also download and run it localy with `ruby main.rb`

# Features
## Lexer
Lexer creates a stream of tokens for the given input. 
## Parser
Creates a AST ( Apstract Syntax Tree ) with the given token stream
> TODO: Create the parser class and parse the AST to the interpreter
## Interpreter
Executes the given AST to calculate the expression
> Currently, interpreter executes the stream of tokens without building an AST

# Examples
```
	calc> 2 + 3 / 3
	=> 3
	calc> 2 * 3 + 5 * 2
	=> 16
	calc> 3 * 3 * 3 + 2 / 2 - 1
	=> 27
```

# Test cases
To run full test suit run the command `bundle exec rspec`
