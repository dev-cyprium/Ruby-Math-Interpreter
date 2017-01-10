# About
Welcome to my Ruby Pascal interpreter project. The idea behind this project came to me when I was unable to finish
an exercise on some website. The exercise was to make a parser to handle some custom file format.
Atempting to learn parsers/interpreters I've written a simple Pascal interpreter in ruby that supports
basic Pascal programms.
This project is fully tested with RSpec, and you can also download and run it localy with `ruby pascal.rb program.pas`

# Features
## Lexer
Lexer creates a stream of tokens for the given pascal program. 
## Parser
Creates a AST ( Apstract Syntax Tree ) with the given token stream.
## Interpreter
Executes the given AST to calculate the Pascal code.

# Test cases
To run full test suit run the command `bundle exec rspec`
