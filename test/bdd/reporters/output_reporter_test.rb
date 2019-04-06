require_relative '../../bdd_helper'

require 'stringio'

describe 'Bdd' do
  describe 'OutputReporter' do
    subject { Bdd::OutputReporter }

    let(:path_data_source) { 'examples/yml_expected.yml' }
    let(:path_expected_output) { 'test/fixtures/output_reporter.txt' }

    describe "report" do
      it 'works' do
        # loads data
        data = Bdd::Data.new
        data.hash_table = YAML.load_file(path_data_source)

        # verifies data
        assert_equal(['Bdd'], data.hash_table.keys)
        assert_equal(["Auto Sorting", "Filters", "Language", "Simple Unpassing Examples"], data.hash_table['Bdd'].keys)

        # loads actual_io_content
        io = StringIO.new
        subject.report(data, io)
        actual_io_content = io.string

        # loads expected_io_content
        # File.write(path_expected_output, actual_io_content)
        expected_io_content = File.read(path_expected_output)

        # tests
        assert_equal(expected_io_content, actual_io_content)
      end
    end
  end
end
