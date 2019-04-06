require 'bdd/version'

module Bdd
  module_function

  # Core
  autoload :Configuration, 'bdd/core/configuration'
  autoload :Data, 'bdd/core/data'
  autoload :Instance, 'bdd/core/instance'

  # Adapters
  autoload :FrameworkAdapter, 'bdd/adapters/framework_adapter'
  autoload :LanguageAdapter, 'bdd/adapters/language_adapter'
  autoload :MethodsAdapter, 'bdd/adapters/methods_adapter'
  autoload :ReportAdapter, 'bdd/adapters/report_adapter'

  # Frameworks
  autoload :RspecFramework, 'bdd/frameworks/rspec_framework'
  autoload :MinitestFramework, 'bdd/frameworks/minitest_framework'

  # Reports
  autoload :OutputReporter, 'bdd/reporters/output_reporter'
  autoload :YamlReporter, 'bdd/reporters/yaml_reporter'

  # Utils
  autoload :ColorUtils, 'bdd/utils/color_utils'

  def instance
    @instance ||= Instance.new
  end

  def configure(&block)
    yield configuration
  end

  def configuration
    instance.configuration
  end
end

# Ruby <= 2.0
unless [].respond_to?(:to_h)
  class Array
    def to_h
      h = {}
      each { |a, b| h[a] = b }
      h
    end
  end
end
