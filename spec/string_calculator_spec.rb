require_relative '../lib/string_calculator'

RSpec.describe StringCalculator do
  subject { described_class.new }

  describe '#add' do
    context 'for an empty string' do
      it 'returns 0 for an empty string' do
        expect(subject.add('')).to eq(0)
      end
    end

    context 'for non-string input' do
      it 'raises ArgumentError for non-string input' do
        expect { subject.add(100) }.to raise_error(ArgumentError, 'Input must be a string')
      end
    end

    context 'for single number' do
      it 'returns the number itself' do
        expect(subject.add('10')).to eq(10)
      end
    end

    context 'for comma-separated numbers' do
      it 'returns the sum of numbers' do
        expect(subject.add('11, 22, 33')).to eq(11 + 22 + 33)
      end

      it 'returns the sum of numbers for space after the number' do
        expect(subject.add('11 ,22 ,33')).to eq(11 + 22 + 33)
      end

      it 'returns the sum of numbers for space before the number' do
        expect(subject.add(' 11, 22, 33')).to eq(11 + 22 + 33)
      end

      it 'returns the sum of numbers if space before and after the number' do
        expect(subject.add(' 11  , 22  , 33')).to eq(11 + 22 + 33)
      end

      it 'returns invalid input if empty space between two numbers' do
        expect { subject.add('11,  2 2, 33') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add('1 1,  2 2, 33') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add('1 1,22,33') }.to raise_error(ArgumentError, 'Invalid input')
      end
    end

    context 'for new line-separated numbers' do
      it 'returns the sum of numbers' do
        expect(subject.add("11\n22\n33")).to eq(11 + 22 + 33)
        expect(subject.add("11,22\n33")).to eq(11 + 22 + 33)
        expect(subject.add("11\n22,33")).to eq(11 + 22 + 33)
      end
    end

    context 'for invalid input with comma followed by new line or viceversa' do
      it 'raises ArgumentError' do
        expect { subject.add("1,\n2") }.to raise_error(ArgumentError)
        expect { subject.add("1\n,2") }.to raise_error(ArgumentError)
      end
    end

    context 'with different delimiters' do
      it 'supports custom delimiter' do
        expect(subject.add("//;\n1;2")).to eq(3)
      end

      it 'supports custom delimiter with different numbers' do
        expect(subject.add("//;\n1;2;3;4")).to eq(10)
      end

      it 'supports custom delimiter with new lines' do
        expect(subject.add("//*\n1\n2*3\n4")).to eq(10)
      end

      it 'supports custom delimiter with mixed delimiters' do
        expect(subject.add("//#\n1\n2,3\n4#5")).to eq(15)
      end

      it 'raises ArgumentError for invalid input with custom delimiter' do
        expect { subject.add("//;\n1;\n2") }.to raise_error(ArgumentError)
      end
    end

    context 'with negative numbers' do
      it 'raises ArgumentError with single negative number' do
        expect { subject.add('1,-2,3') }.to raise_error(ArgumentError, 'Negative numbers not allowed: -2')
      end

      it 'raises ArgumentError with multiple negative numbers' do
        expect { subject.add('-1,-2,3,-4') }.to raise_error(ArgumentError, 'Negative numbers not allowed: -1, -2, -4')
      end

      it 'raises ArgumentError with custom delimiter and negative numbers' do
        expect { subject.add("//;\n1;-2;3;-4") }.to raise_error(ArgumentError, 'Negative numbers not allowed: -2, -4')
      end
    end

    context 'For invalid inputs' do
      it 'raises ArgumentError and return invalid input' do
        expect { subject.add('1,2,') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add(',1,2') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add(',1,2,') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add('1,,2') }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add('1 1,2') }.to raise_error(ArgumentError, 'Invalid input')

        expect { subject.add("1,2\n") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("\n1,2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("1\n\n2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("1,\n2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("1,\n,2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("1\n,2 2") }.to raise_error(ArgumentError, 'Invalid input')

        # For Custom Delimitor Invalid Inouts

        expect { subject.add("//;\n;1;2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("//;\n1;2;") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("//*\n*1,2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("//*\n1*2*") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("//#\n1##2") }.to raise_error(ArgumentError, 'Invalid input')
        expect { subject.add("//#\n1 1# 2") }.to raise_error(ArgumentError, 'Invalid input')

        expect { subject.add("1\n2#3") }.to raise_error(ArgumentError, 'Invalid input')
      end
    end
  end
end