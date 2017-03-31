# Bdd

Bdd is Cucumber without Regex. Compatible with both RSpec and Minitest.



## Status

| Is It Working? | Is It Tested? | Code Quality |
|:---|:---|:---|
| [![Master Build Status](https://api.travis-ci.org/thejamespinto/bdd.svg?branch=master)](https://travis-ci.org/thejamespinto/bdd) | [![Code Climate](https://codeclimate.com/github/thejamespinto/bdd/coverage.svg)](https://codeclimate.com/github/thejamespinto/bdd) | [![Code Climate](https://codeclimate.com/github/thejamespinto/bdd.svg)](https://codeclimate.com/github/thejamespinto/bdd) |
| **# of Downloads** | **Maintainance Status** | **Get Involved!** |
| [![Downloads](http://img.shields.io/gem/dt/bdd.svg)](https://rubygems.org/gems/bdd) | [![Dependency Status](https://gemnasium.com/badges/github.com/thejamespinto/bdd.svg)](https://gemnasium.com/github.com/thejamespinto/bdd) | [![GitHub Issues](https://img.shields.io/github/issues/thejamespinto/bdd.svg)](https://github.com/thejamespinto/bdd/issues) |






## Installation



#### RSpec

```ruby
# Gemfile

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails' # if you are using Rails
  gem 'bdd'
end
```

```ruby
# spec/spec_helper.rb

require 'bdd/rspec'

RSpec.configure do |config|
  config.color = true
  config.default_formatter = Bdd::RSpec::Formatter
end

# Optionally, add your language:
# Bdd.add_language(pre_conditions, post_conditions, conjunctions)
# Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English
# Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese
# Bdd.add_language(%w[DadoQue], %w[Cuando Entonces], %w[Y Pero]) # Spanish
# Bdd.add_language(%w[Zakładając], %w[Jeśli To], %w[Także Ale]) # Polish
```



#### Minitest

```ruby
# Gemfile

group :development, :test do
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'minitest-rails' # if you are using Rails
  gem 'bdd'
end
```

```ruby
# test/test_helper.rb

require 'bdd/minitest'

Minitest::Reporters.use!(Bdd::Minitest::Reporter.new)

# Optionally, add your language:
# Bdd.add_language(pre_conditions, post_conditions, conjunctions)
# Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English
# Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese
# Bdd.add_language(%w[DadoQue], %w[Cuando Entonces], %w[Y Pero]) # Spanish
# Bdd.add_language(%w[Zakładając], %w[Jeśli To], %w[Także Ale]) # Polish
```








## Usage

File `spec/features/search_spec.rb`

```ruby
context 'Searching' do
  it 'Result is found' do
    Given 'I am on the search page' do
      visit '/search'
      expect(page).to have_content('Search')
    end

    When 'I search something' do
      fill_in 'Search', with: 'John'
      click_button 'Go'
    end

    Then 'I should see the word result' do
      expect(page).to have_content('Result')
    end
  end
end
```

Run tests

`rspec spec/features/search_spec.rb`

Output

<pre>
<b>Searching</b>
  <b>Result is found</b>
    <b>Given</b> I am on the search page
    <b> When</b> I search something
    <b> Then</b> I should see the word result
</pre>


#### More Examples

* [READ ALL EXAMPLES](http://github.com/thejamespinto/bdd/tree/master/examples)

<br><br><br><br>






## Customize

By default, Bdd adds the following methods to you `Given`, `When`, `Then`, `And` and `But`.

You may need more! Bdd will help you with that too.

```ruby
# example with words

Bdd.add_language(pre_conditions, post_conditions, conjunctions)

Bdd.add_language(%w[Given], %w[When Then], %w[And But])

Bdd.add_language(%w[], %w[], %w[AndGiven AndThen ButGiven ButThen])

Bdd.add_language(%w[PreCondition], %w[When PostCondition], %w[And But])

Bdd.add_language(%w[Background], %w[When Expects], %w[And But])

```

```ruby
# example with languages

Bdd.add_language(pre_conditions, post_conditions, conjunctions)

Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English

Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese

Bdd.add_language(%w[DadoQue], %w[Cuando Entonces], %w[Y Pero]) # Spanish

Bdd.add_language(%w[Zakładając], %w[Jeśli To], %w[Także Ale]) # Polish
```





## Why

This gem helps teams write better tests.

#### It Helps Testers

* Define clear pre and post-conditions;
* Organize tests;
* Visualize blindspots;
* Highlight variations between scenarios (between examples);

#### It Helps Developers

* Maintain clean code;
* Predict side effects;
* Scan titled steps;
* Save time interpreting code;
* Remove the need for comments;

#### It Helps New Team Members

* Replace a user manual;

#### It Helps Stakeholders

* See the big picture;

#### It Helps Business Analysts

* Understand complexity;
* Weight requirements;
* Postpone demands;

### It Helps Project Managers

* Estimate time;
* Measure scenarios per sub-system;





## Authors

* [James Pinto](http://github.com/thejamespinto)



## Contributing

1. Fork it ( https://github.com/thejamespinto/bdd/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Alternatives

These are some other gems that solve similar problems in similar ways

|              | [rspec-given](https://github.com/jimweirich/rspec-given) | [rspec-example_steps](https://github.com/railsware/rspec-example_steps) | [cucumber](https://github.com/cucumber/cucumber)    | [bdd](https://github.com/thejamespinto/bdd)   |
| ---          | ---         | ---                 | ---         | ---             |
| Quantity     | More Tests  | More Tests          | Fewer Tests | __Fewer Tests__ |
| Granurality  | Assertion   | Assertion           | Example     | __Example__     |
| Output Level | Example     | Example             | Assertion   | __Assertion__   |
| Best For     | Units       | Units               | Acceptance  | __Acceptance__  |
| Regexp       | -           | -                   | 😞 Yes       | __No Need__ 😎 |
| Extra layer  | -           | -                   | 😭 Yes       | __No Need__  😎|
| Capybara     | Yes         | Yes                 | Yes         | __Yes__         |
| RSpec        | Yes         | Yes                 | Yes         | __Yes__         |
| Minitest     | -           | -                   | -           | __Yes__  😍     |


## FAQ

__Q:__ Is it awesome?
__A:__ Yes.

__Q:__ Does it use Regex?
__A:__ No.

__Q:__ That's it?
__A:__ That's it!







