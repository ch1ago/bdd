# FIRST, RUN EACH FRAMEWORK'S SPECIFIC
`ruby test_frameworks/test_minitest_test.rb`
`rspec test_frameworks/test_rspec_test.rb`

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest/autorun'

# DON'T CONFIGURE BDD HERE

# TESTS HERE

describe 'Bdd' do
  describe 'Each Framework' do
    let(:actual_rspec) { File.read('test_frameworks/yml_rspec_report.yml') }
    let(:actual_minitest) { File.read('test_frameworks/yml_minitest_report.yml') }
    let(:expected) { File.read('test_frameworks/yml_expected.yml') }

    it 'validates RSpec output' do
      assert_equal actual_rspec, expected
    end

    it 'validates Minitest output' do
      assert_equal actual_minitest, expected
    end
  end
end
