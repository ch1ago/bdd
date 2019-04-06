require_relative '../../bdd_helper'

describe 'Bdd' do
  describe 'FrameworkAdapter' do
    subject { Bdd::FrameworkAdapter }

    # TODO: describe "write"
    # TODO: describe "define_method_on_example"
    # TODO: describe "define_method_before_example"
    # TODO: describe "define_method_after_example"

    describe "get" do
      it 'minitest' do
        assert_equal(Bdd::MinitestFramework, subject.get('minitest'))
      end

      it 'rspec' do
        assert_equal(Bdd::RspecFramework, subject.get('rspec'))
      end

      it 'other' do
        assert_raises(Bdd::FrameworkAdapter::InvalidInput) do
          subject.get('other')
        end
      end
    end

    describe "get titles for" do
      it 'MinitestFramework' do
        arg_framework = Bdd::MinitestFramework
        arg_example = Bdd::MinitestFramework.current_example
        #
        actual = subject.get_titles_for(arg_framework, arg_example)
        expected = ["Bdd", "FrameworkAdapter", "get titles for", "MinitestFramework"]
        assert_equal(expected, actual)
      end

      it 'RspecFramework' do
        arg_framework = Bdd::RspecFramework
        # arg_example = Bdd::RspecFramework.current_example
        arg_example = get_rspec_example_mock
        #
        actual = subject.get_titles_for(arg_framework, arg_example)
        expected = ["Bdd", "FrameworkAdapter", "get titles for", "RspecFramework"]
        assert_equal(expected, actual)
      end

      def get_rspec_example_mock
        mock = Minitest::Mock.new
        mock_0 = Minitest::Mock.new
        mock_1 = Minitest::Mock.new
        mock_2 = Minitest::Mock.new
        mock_3 = Minitest::Mock.new

        mock.expect(:example_group, mock_0)
        mock.expect(:metadata, {description: 'RspecFramework'})

        mock_0.expect(:parent_groups, [mock_3, mock_2, mock_1])

        mock_1.expect(:metadata, {description: 'Bdd'})
        mock_2.expect(:metadata, {description: 'FrameworkAdapter'})
        mock_3.expect(:metadata, {description: 'get titles for'})

        mock
      end
    end
  end
end
