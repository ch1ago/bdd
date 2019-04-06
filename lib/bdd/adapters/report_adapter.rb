module Bdd
  module ReportAdapter
    module_function

    class Error < StandardError; end
    class InvalidInput < Error; end

    def list(*array)
      return defaults if array.empty?

      hash = (array.last.is_a? Hash) ? array.pop : {}

      ret = {}

      array.each do |symbol|
        report = get(symbol)
        ret[report] = {}
      end

      hash.each do |symbol, options|
        report = get(symbol)
        ret[report] = options
      end

      ret
    end

    def defaults
      list(:yaml, :output)
    end

    def get(symbol)
      name = "Bdd::#{symbol.to_s.capitalize}Report"
      Object.const_get(name)
    rescue NameError
      raise InvalidInput, <<-STR
#{symbol} is not a valid input
because it means there needs to be a module named #{name}.
Valid inputs are: :output, :yaml
Multiple inputs are allowed
STR
    end

    def report(data, reports_hash)
      reports_hash.each do |report, args|
        report.report(data, args)
      end
    end
  end
end
