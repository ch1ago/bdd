# FIRST, RUN EACH FRAMEWORK'S SPECIFIC
`ruby examples/test_minitest_test.rb`
`rspec examples/test_rspec_test.rb`

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest/autorun'

# DON'T CONFIGURE BDD HERE

# TESTS HERE

describe 'Bdd' do
  describe 'Each Framework' do
    let(:actual_rspec) { File.read('examples/yml_rspec_report.yml') }
    let(:actual_minitest) { File.read('examples/yml_minitest_report.yml') }
    let(:expected) { File.read('examples/yml_expected.yml') }

    it 'validates RSpec output' do
      assert_equal actual_rspec, expected
    end

    it 'validates Minitest output' do
      assert_equal actual_minitest, expected
    end
  end
end
