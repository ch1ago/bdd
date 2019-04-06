module Bdd
  # TESTED
  class Data
    attr_writer :hash_table

    def hash_table
      @hash_table ||= {}
    end

    # TESTED
    def write(keys, status, title, string)
      node = _write_find_node(keys)
      node << [status, title, string]
    end

    def _write_find_node(keys)
      node = hash_table

      context_keys = keys[0..-2]
      example_key = keys[-1]

      context_keys.each do |key|
        node = node[key] ||= {}
      end

      node = node[example_key] ||= []

      node
    end

    # TESTED
    def read
      _read_deep_sort(hash_table)
    end

    # sorts alphabetically
    def _read_deep_sort(hash)
      hash.sort.map do |k, v|
        if v.is_a? Hash
          [k, _read_deep_sort(v)]
        else
          [k, v]
        end
      end.to_h
    end
  end
end
