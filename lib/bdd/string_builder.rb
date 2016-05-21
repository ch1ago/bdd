module Bdd
  class StringBuilder
    attr_reader :string

    def initialize(string)
      @string = Colors.add(Title.adjust(string), :white, :bold)
    end

    def append_success(string)
      @string << Colors.add(string, :green)
    end

    def append_pending(string)
      @string << Colors.add(string, :yellow)
    end

    def append_failure(string)
      @string << Colors.add(string, :red)
    end

  end
end
