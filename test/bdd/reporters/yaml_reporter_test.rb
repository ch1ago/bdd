require_relative '../../bdd_helper'

require 'stringio'

describe 'Bdd' do
  describe 'YamlReporter' do
    subject { Bdd::YamlReporter }

    let(:path_data_source) { 'examples/yml_expected.yml' }

    describe "report" do
      it 'works' do
        # loads data
        data = Bdd::Data.new
        data.hash_table = YAML.load_file(path_data_source)

        # verifies data
        assert_equal(['Bdd'], data.hash_table.keys)
        assert_equal(["Auto Sorting", "Filters", "Language", "Simple Unpassing Examples"], data.hash_table['Bdd'].keys)

        # generates report
        fname = "tmp/yaml_reporter_#{Time.now.to_i}.yml"
        subject.report(data, fname)

        # tests
        assert(File.exist?(fname), 'YML file was not created')
      end
    end
  end
end
