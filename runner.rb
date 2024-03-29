require_relative 'lib/string_calculator'
# Runner class to demonstrate StringCalculator functionality

class Runner
  def initialize
    @calculator = StringCalculator.new
  end

  def run
    raise 'No string passed' if ARGV.count.zero?
    raise 'Need one string argument only' if ARGV.count != 1

    string = ARGV[0]
    # The purpose of this line is to replace occurrences of the string "\\n" with the actual newline character "\n" in the given input string.
    # In Ruby, when we pass arguments from the command line, special characters like "\n" might be represented as "\\n".
    string = string.gsub('\\n', "\n")
    puts "sum = #{@calculator.add(string)}"
  rescue => e
    puts "Error: #{e.message}"
  end
end

Runner.new.run