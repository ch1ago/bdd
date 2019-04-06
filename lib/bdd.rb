require 'bdd/version'

module Bdd
  module_function

  # Core
  autoload :Configuration, 'bdd/core/configuration'
  autoload :Data, 'bdd/core/data'
  autoload :Instance, 'bdd/core/instance'

  # Adapters
  autoload :FrameworkAdapter, 'bdd/adapters/framework_adapter'
  autoload :ReportAdapter, 'bdd/adapters/report_adapter'

  # Frameworks
  autoload :RspecFramework, 'bdd/frameworks/rspec_framework'
  autoload :MinitestFramework, 'bdd/frameworks/minitest_framework'

  # Reports
  autoload :OutputReport, 'bdd/reports/output_report'
  autoload :YamlReport, 'bdd/reports/yaml_report'

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
