module Bdd
  module OutputReport
    module_function

    def report(data, *args)
      puts "\n" * 3
      _deep_output data.read
      puts "\n" * 3
    end

    # obj is either a 'Hash' or an 'Array of Array'
    def _deep_output(obj, depth: 0)
      if obj.is_a? Hash
        obj.each do |k, v|
          print '  ' * depth
          puts k.to_s
          _deep_output(v, depth: depth+1)
        end
      else
        obj.each do |array|
          key = array[0]
          title = _adjust(array[1])
          text = array[2]
          print '  ' * depth
          print ColorUtils.color(key, title)
          print ' '
          puts text
        end
      end
    end

    def _adjust(s)
      length = 9 - s.length
      s.rjust(length)
    end
  end
end
