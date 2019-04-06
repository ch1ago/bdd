require_relative '../../bdd_helper'

describe 'Bdd' do
  describe 'Data' do
    subject { Bdd::Data.new }

    describe 'write' do
      it 'stores data as expected' do
        subject.write(['Access Restriction', 'Authentication', 'Guests cannot access the home page'], :passed, 'Given', 'AAA')
        subject.write(['Access Restriction', 'Authentication', 'Guests cannot access the home page'], :passed, 'When', 'BBB')
        subject.write(['Access Restriction', 'Authentication', 'Guests cannot access the home page'], :passed, 'Then', 'CCC')

        expected = {
          "Access Restriction"=>{
            "Authentication"=>{
              'Guests cannot access the home page' => [
                [:passed, "Given", "AAA"],
                [:passed, "When", "BBB"],
                [:passed, "Then", "CCC"]
              ]
            }
          }
        }
        assert_equal(expected, subject.hash_table)

        subject.write(['Access Restriction', 'Authentication', 'Users cannot access the sign in page'], :passed, 'Given', 'DDD')
        subject.write(['Access Restriction', 'Authentication', 'Users cannot access the sign in page'], :passed, 'When', 'EEE')
        subject.write(['Access Restriction', 'Authentication', 'Users cannot access the sign in page'], :passed, 'Then', 'FFF')

        expected = {
          "Access Restriction"=>{
            "Authentication"=>{
              'Guests cannot access the home page' => [
                [:passed, "Given", "AAA"],
                [:passed, "When", "BBB"],
                [:passed, "Then", "CCC"]
              ],
              "Users cannot access the sign in page"=>[
                [:passed, "Given", "DDD"],
                [:passed, "When", "EEE"],
                [:passed, "Then", "FFF"]
              ]
            }
          }
        }
        assert_equal(expected, subject.hash_table)

        subject.write(['Access Restriction', 'Authorization', 'Admins can access the dashboard'], :passed, 'Given', 'GGG')
        subject.write(['Access Restriction', 'Authorization', 'Admins can access the dashboard'], :passed, 'When', 'HHH')
        subject.write(['Access Restriction', 'Authorization', 'Admins can access the dashboard'], :passed, 'Then', 'III')

        expected = {
          "Access Restriction"=>{
            "Authentication"=>{
              'Guests cannot access the home page' => [
                [:passed, "Given", "AAA"],
                [:passed, "When", "BBB"],
                [:passed, "Then", "CCC"]
              ],
              "Users cannot access the sign in page"=>[
                [:passed, "Given", "DDD"],
                [:passed, "When", "EEE"],
                [:passed, "Then", "FFF"]
              ]
            },
            "Authorization"=>{
              'Admins can access the dashboard' => [
                [:passed, "Given", "GGG"],
                [:passed, "When", "HHH"],
                [:passed, "Then", "III"]
              ]
            }
          }
        }
        assert_equal(expected, subject.hash_table)

        subject.write(['Access Restriction', 'Authorization', 'Users cannot access the dashboard'], :passed, 'Given', 'JJJ')
        subject.write(['Access Restriction', 'Authorization', 'Users cannot access the dashboard'], :passed, 'When', 'KKK')
        subject.write(['Access Restriction', 'Authorization', 'Users cannot access the dashboard'], :failed, 'Then', 'LLL')

        expected = {
          "Access Restriction"=>{
            "Authentication"=>{
              'Guests cannot access the home page' => [
                [:passed, "Given", "AAA"],
                [:passed, "When", "BBB"],
                [:passed, "Then", "CCC"]
              ],
              "Users cannot access the sign in page"=>[
                [:passed, "Given", "DDD"],
                [:passed, "When", "EEE"],
                [:passed, "Then", "FFF"]
              ]
            },
            "Authorization"=>{
              'Admins can access the dashboard' => [
                [:passed, "Given", "GGG"],
                [:passed, "When", "HHH"],
                [:passed, "Then", "III"]
              ],
              'Users cannot access the dashboard' => [
                [:passed, "Given", "JJJ"],
                [:passed, "When", "KKK"],
                [:failed, "Then", "LLL"]
              ]
            }
          }
        }
        assert_equal(expected, subject.hash_table)
      end
    end
  end
end
