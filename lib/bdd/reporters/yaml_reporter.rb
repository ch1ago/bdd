require 'yaml'

module Bdd
  module YamlReporter
    module_function

    def report(data, path = 'bdd_report.yml')
      path = "#{`pwd`.strip}/#{path}"

      content = data.read.to_yaml
      File.write(path, content)

      puts "Stories report generated to #{path}"
    end
  end
end
