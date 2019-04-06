require_relative '../../units_helper'

describe 'Bdd' do
  describe 'ReportAdapter' do
    subject { Bdd::ReportAdapter }

    # TODO: describe "list"
    # TODO: describe "report"

    describe "get" do
      it 'yaml' do
        assert_equal(Bdd::YamlReport, subject.get('yaml'))
      end

      it 'output' do
        assert_equal(Bdd::OutputReport, subject.get('output'))
      end

      it 'other' do
        assert_raises(Bdd::ReportAdapter::InvalidInput) do
          subject.get('other')
        end
      end
    end

    describe "defaults" do
      it 'works' do
        expected = {Bdd::YamlReport=>{}, Bdd::OutputReport=>{}}
        assert_equal(expected, subject.defaults)
      end
    end

  end
end
