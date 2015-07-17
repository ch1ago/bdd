module RSpecFormatterSupport
  def reporter(*streams)
    @reporter ||=
      begin
        config.add_formatter described_class, *streams
        config.reporter
      end
  end

  def formatter_output
    @formatter_output ||= StringIO.new
  end

  private

  def config
    @configuration ||=
      begin
        config = RSpec::Core::Configuration.new
        config.output_stream = formatter_output
        config
      end
  end
end
