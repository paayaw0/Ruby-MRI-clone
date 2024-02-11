class NumericTokenizer
    attr_reader :input, :ln, :col, :type

    def self.call(input: nil, ln: nil, col: nil, type: nil)
        new(input: input, ln: ln, col: col, type: type)
    end

    def initialize(input:, ln:, col:, type:)
        @input = input
        @ln = ln
        @col = col
        @type = type
    end
end