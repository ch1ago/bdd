module Bdd
  # If you believe this should actually be a singleton,
  # please open an Issue or Pull Request and state your reasoning.
  class Instance
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new(self)
    end

    def data
      @data ||= Data.new
    end

    def run_reports!
      ReportAdapter.report(
        data,
        configuration.reporters
      )
    end
  end
end
