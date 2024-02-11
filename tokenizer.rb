require 'byebug'

require_relative 'reserved_keywords'
require_relative 'operators'
Dir['./tokenizers/**.rb'].each { |f| require_relative f }

def tokenize(text_stream, ln)   
    text_stream = text_stream.each_char
    token_stream = []
    col = 0
    temp = ''

    begin
        while char = text_stream.next
            col += 1

            next if char.match?(/\s/)

            case
            # In creating Numeric tokens we have to consider the scenarios below
            # 1. is current character followed by a dot, space or another numeric?
            when char.match?(/^\d$/)
                begin
                    next_char = text_stream.peek
                rescue StopIteration
                    # if next value is end of line we create NumericToken with current char
                    temp << char
                    token_stream << NumericTokenizer.(input: temp, ln: ln, col: col, type: :integer)
                    temp = ''
                    next
                end

                case next_char
                when /\d/, /_/
                    temp << char
                    temp << next_char if next_char == '_'
                when  '.'
                    temp << char
                    token_stream << NumericTokenizer.(input: temp, ln: ln, col: col, type: :integer)
                    temp = ''
                    token_stream << StringTokenizer.(input: next_char, ln: ln, col: col, type: :dot)
                when /\s/
                    temp << char
                    token_stream << NumericTokenizer.(input: temp, ln: ln, col: col, type: :integer)
                    temp = ''
                end

            when char.match?(/^[a-zA-Z]$/)
            #    some code here

            when OPERATORS.include?(char)
                type =
                case char
                when '|'
                    :vertical_pipe
                when '+'
                    :addition
                end

                token_stream << OperatorTokenizer.(input: char, ln: ln, col: col, type: type)
            end
        end
    rescue StopIteration
        # do nothing for now
    end

    token_stream
end

def token_type(temp)
    if KEYWORDS.include?(temp)
        :keyword
    else
        :identifier
    end
end