require_relative '../../bdd_helper'

describe 'Bdd' do
  describe 'ReportAdapter' do
    subject { Bdd::ReportAdapter }

    # TODO: describe "list"
    # TODO: describe "report"

    describe "get" do
      it 'yaml' do
        assert_equal(Bdd::YamlReporter, subject.get('yaml'))
      end

      it 'output' do
        assert_equal(Bdd::OutputReporter, subject.get('output'))
      end

      it 'other' do
        assert_raises(Bdd::ReportAdapter::InvalidInput) do
          subject.get('other')
        end
      end
    end

    describe "defaults" do
      it 'works' do
        expected = {Bdd::YamlReporter=>[], Bdd::OutputReporter=>[]}
        assert_equal(expected, subject.defaults)
      end
    end

  end
end
