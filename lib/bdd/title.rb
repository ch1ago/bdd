module Bdd
  module Title
    class << self
      def adjust(title)
        if @last_title == title
          title = ''
        else
          @last_title = title
        end
        "#{title.rjust(length)} "
      end

      attr_reader :length

      def length=(v)
        @length ||= 0
        @length = v if @length < v
      end

    end
  end
end
