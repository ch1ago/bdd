require_relative '../../bdd_helper'

describe 'Bdd' do
  describe 'Data' do
    subject { Bdd::Data.new }

    describe "read" do
      it 'ignores arrays' do
        subject.hash_table = {
          'aaa' => [
            [:status_zzz, "Given", "text"],
            [:status_yyy, "When", "text"],
            [:status_xxx, "Then", "text"]
          ],
          "bbb"=>[
            [:status_mmm, "Given", "text"],
            [:status_ooo, "When", "text"],
            [:status_nnn, "Then", "text"]
          ],
          'ccc' => [
            [],
            [],
            []
          ],
          'ddd' => []
        }
        actual = subject.read
        assert_equal(subject.hash_table, actual)

        assert_equal(["aaa", "bbb", "ccc", "ddd"], actual.keys)
        assert_equal(3, actual['aaa'].length)
        assert_equal(3, actual['bbb'].length)
        assert_equal(3, actual['ccc'].length)
        assert_equal(0, actual['ddd'].length)
      end

      it 'sorts keys alphabetically' do
        subject.hash_table = {
          "f"=>{
            'd' => [],
            "a" => []
          },
          "b"=>{
            'e' => [],
            'c' => []
          }
        }

        actual = subject.read

        assert_equal(["b", "f"], actual.keys)
        assert_equal(["c", "e"], actual['b'].keys)
        assert_equal(["a", "d"], actual['f'].keys)
      end
    end
  end
end
