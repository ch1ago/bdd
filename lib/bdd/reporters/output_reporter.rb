module Bdd
  module OutputReporter
    module_function

    def report(data, io = $stdout)
      io.puts "\n" * 3
      _deep_output(io, data.read)
      io.puts "\n" * 3
    end

    # obj is either a 'Hash' or an 'Array of Array'
    def _deep_output(io, obj, depth: 0)
      if obj.is_a? Hash
        obj.each do |k, v|
          io.print '  ' * depth
          io.puts k.to_s
          _deep_output(io, v, depth: depth+1)
        end
      else
        obj.each do |array|
          key = array[0]
          title = _adjust(array[1])
          text = array[2]
          io.print '  ' * depth
          io.print ColorUtils.color(key, title)
          io.print ' '
          io.puts text
        end
      end
    end

    def _adjust(s)
      length = 9 - s.length
      s.rjust(length)
    end
  end
end
