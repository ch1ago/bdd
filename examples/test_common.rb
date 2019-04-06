# DON'T load this file directly.

def some_code
  true
end

def some_exception
  raise "foo"
end

describe 'Bdd' do
  describe 'Language' do
    it 'English' do
      Given('x') { some_code }
      But('x1') { some_code }
      When('y') { some_code }
      And('y1') { some_code }
      Then('z') { some_code }
      And('z1') { some_code }
      And('z2') { some_code }
      And('z3') { some_code }
    end

    it 'Portuguese' do
      Dado('x') { some_code }
      Quando('y') { some_code }
      Entao('z') { some_code }
    end
  end

  describe 'Auto Sorting' do
    it 'Example 3' do
      Given('3') { some_code }
    end

    it 'Example 1' do
      Given('1') { some_code }
    end

    it 'Example 2' do
      Given('2') { some_code }
    end
  end

  describe 'Simple Unpassing Examples' do
    describe 'Skip Examples' do
      it 'Skips on empty block' do
        Given('x') { some_code }
        But('x1') { some_code }
        When('y') { some_code }
        And('y1 is skipped')
        Then('z should never happen') { some_code }
        And('z1 should never happen') { some_code }
        And('z2 should never happen') { some_code }
        And('z3 should never happen') { some_code }
      end

      it 'Skips on skip command' do
        Given('x') { some_code }
        But('x1') { some_code }
        When('y') { some_code }
        And('y1 is skipped') { skip }
        Then('z should never happen') { some_code }
        And('z1 should never happen') { some_code }
        And('z2 should never happen') { some_code }
        And('z3 should never happen') { some_code }
      end

      # it 'pending command' do
      #   Given('x') { some_code }
      #   But('x1') { some_code }
      #   When('y') { some_code }
      #   And('y1 is pended') { pending }
      #   Then('z should never happen') { some_code }
      #   And('z1 should never happen') { some_code }
      #   And('z2 should never happen') { some_code }
      #   And('z3 should never happen') { some_code }
      # end
    end

    describe 'Fail Examples' do
      it 'Fails on unmet expectations' do
        Given('x') { some_code }
        But('x1') { some_code }
        When('y') { some_code }
        And('y1') { some_code }
        Then('z') { some_code }
        And('z1 expectations fail') { some_failed_expectation }
        And('z2 should never happen') { some_code }
        And('z3 should never happen') { some_code }
      end

      it 'Fails on raised exceptions' do
        Given('x') { some_code }
        But('x1') { some_code }
        When('y') { some_code }
        And('y1') { some_code }
        Then('z') { some_code }
        And('z1 expectations fail') { some_exception }
        And('z2 should never happen') { some_code }
        And('z3 should never happen') { some_code }
      end
    end
  end

  describe 'Filters' do
    describe 'Passing Examples' do
      Given('BEFORE IT ALL') { some_code }

      it 'Example 1' do
        When('foo 1') { some_code }
      end

      it 'Example 2' do
        When('foo 2') { some_code }
      end

      it 'Example 3' do
        When('foo 3') { some_code }
      end

      Then('AFTER IT ALL') { some_code }
    end

    describe 'Filtered Unpassing Examples' do
      describe 'Skip Examples' do
        describe 'On Empty Block' do
          describe 'Pre Condition' do
            Given('x is skipped by empty block')

            it 'Example' do
              When('y should never happen') { some_code }
            end
          end

          describe 'Post Condition' do
            it 'Example' do
              When('y') { some_code }
            end

            Then('z is skipped by empty block')
          end
        end

        describe 'On Skip Command' do
          describe 'Pre Condition' do
            Given('x is skipped by the skip command') { skip }

            it 'Example' do
              When('y should never happen') { some_code }
            end
          end

          describe 'Post Condition' do
            it 'Example' do
              When('y') { some_code }
            end

            Then('z is skipped by the skip command') { skip }
          end
        end

        # it 'pending command' do
        #   Given('x') { some_code }
        #   But('x1') { some_code }
        #   When('y') { some_code }
        #   And('y1 is pended') { pending }
        #   Then('z should never happen') { some_code }
        #   And('z1 should never happen') { some_code }
        #   And('z2 should never happen') { some_code }
        #   And('z3 should never happen') { some_code }
        # end
      end

      describe 'Fail Examples' do
        it 'Fails on unmet expectations' do
          Given('x') { some_code }
          When('y') { some_code }
        end

        Then ('z1 expectations fail') { some_failed_expectation }
      end
    end
  end
end
