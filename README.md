# About
Welcome to my Ruby Math interpreter project. The idea behind this project came to me when I was unable to finish
an exercise on some website. The exercise was to make a parser to handle some custom file format.
Atempting to learn parsers/interpreters I've written a fully-featured math interpreter in ruby that support
four basic math operations: *, +, -, /
This project is fully tested with RSpec, and you can also download and run it localy with `ruby main.rb`

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
Here is the full test suit log:
