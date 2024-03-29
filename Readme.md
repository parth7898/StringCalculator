# StringCalculator

StringCalculator is a Ruby library that performs calculations on strings containing numbers. It supports various delimiters, custom delimiters, and handles invalid input gracefully.

## Installation

Clone this repository to your local machine:

```bash
git clone https://github.com/alkeshrails/StringCalculator.git

```

## Usage
Main class is ```StringCalculator``` but to assume ```Runner``` class as a wrapper.

Navigate to the project directory and run the runner.rb script using Ruby:

```ruby
ruby runner.rb ""              # will return 0
ruby runner.rb "1"             # will return 1
```
Return sum of comma separated numbers:
```ruby
ruby runner.rb "1,2"             # will return 3
ruby runner.rb "1,2,3"           # will return 6
```


Allow the add method to handle new lines between numbers (instead of commas).

The following input is valid: ```1\n2,3``` (will return 6)
The following input is invalid: ```1,\n```

```ruby
ruby runner.rb "1\n2\n3"       # will return 6
```
For Invalid Inputs:
```ruby
ruby runner.rb "1,2,"          # will raise error Invalid Input
ruby runner.rb "1,2\n"         # will raise error Invalid Input
ruby runner.rb "\n1,2"         # will raise error Invalid Input
```

Also use custom delimiter:

To change delimiter, the beginning of the string will contain a separate line that looks like this: ```//[delimiter]\n[numbers…]```, for example ```//;\n1;2``` here the delimiter is ```;``` and this should return ```3```.
```ruby
ruby runner.rb "//;\n1;2;3,4\n5"   # will give sum of 1,2,3,4 and 5 which is 15.
```

## Features
Handles empty strings gracefully, returning 0.
Supports single numbers, returning the number itself.
Supports comma-separated numbers and newline-separated numbers, returning their sum.
Supports custom delimiters specified in the input string.
Raises ArgumentError for invalid input, such as negative numbers or empty spaces between numbers.


## Examples

#### Single number
```ruby
ruby runner.rb "5"  # Output: 5
```

#### Comma-separated numbers
```ruby
ruby runner.rb "1,2,3" # Output: 6
```

#### Newline-separated numbers
```ruby
ruby runner.eb "1\n2\n3" # Output: 6
```

#### Custom delimiter specified in input
```ruby
ruby runner.rb "//;\n1;2;3" # Output: 6
```

#### For Invalid String
```ruby
ruby runner.rb "1,2," # Output: Error: Invalid Input
ruby runner.rb ",1,2" # Output: Error: Invalid Input
ruby runner.rb "\n1,2," # Output: Error: Invalid Input
```

#### For Negative Numbers String
```ruby
ruby runner.rb "1,-2,-3,4"
Output: Error: Negative numbers not allowed: -2, -3
```
## Contributing
Contributions are welcome! Please feel free to submit any issues or pull requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details


This single file contains all the information about the StringCalculator library, including usage instructions, features, examples, error handling, contributing guidelines, and licensing details. You can save this content in a file named `README.md` in your project repository for users and contributors to reference.
