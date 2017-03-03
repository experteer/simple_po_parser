module SimplePoParser
  # Split a PO file into single PO message entities (a message is seperated by two newline)
  class Tokenizer
    def initialize
      @messages = []
    end

    def parse_file(path)
      File.open(path, 'r').each_line("\n\n") do |block|
        block.strip! # dont parse empty blocks
        @messages << parse_block(block) if block != ''
      end
      @messages
    end

  private
    def parse_block(block)
      Parser.parse(block)
    end
  end
end
