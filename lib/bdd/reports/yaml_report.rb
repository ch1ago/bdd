require 'yaml'

module Bdd
  module YamlReport
    module_function

    def report(data, *args)
      fname = args[0] || 'bdd_report.yml'
      path = "#{`pwd`.strip}/#{fname}"

      content = data.read.to_yaml
      File.write(path, content)

      puts ColorUtils.add("YAML report saved at #{path}", :green, :bold)
    end
  end
end
