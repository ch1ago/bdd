## Bdd

Bdd brings you cucumber-style Given/When/Then/And/But test reports

### Status

| Our Tests | Latest Version | # of Downloads | Contribute |
| :----: | :----: | :----: | :----: |
| [![Master Build Status](https://travis-ci.org/thejamespinto/bdd.svg?branch=master)](https://travis-ci.org/thejamespinto/bdd) | [![Gem Version](https://img.shields.io/gem/v/bdd.svg)](https://rubygems.org/gems/bdd) | [![Downloads](http://img.shields.io/gem/dt/bdd.svg)](https://rubygems.org/gems/bdd) | [![GitHub Issues](https://img.shields.io/github/issues/thejamespinto/bdd.svg)](https://rubygems.org/gems/bdd) |

[![GitHub License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://rubygems.org/gems/bdd)




### Description

This gem brings two major functionality to your tests

* Verbosity for rspec documentation formatter.
* Ability to comment or describe set of actions in example into some step.








## Installation



### RSpec

```ruby
# Gemfile

group :test do
  gem 'rspec'
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
# Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English
# Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese
# Bdd.add_language(%w[Zakładając], %w[Jeśli To], %w[Także Ale]) # Polish
```



### Minitest

```ruby
# Gemfile

group :test do
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'bdd'
end
```

```ruby
# test/test_helper.rb

require 'bdd/minitest'

Minitest::Reporters.use!(Bdd::Minitest::Reporter.new)

# Optionally, add your language:
# Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English
# Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese
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

`rspec -fd spec/features/search_spec.rb`

Output

<pre>
<b>Searching</b>
  <b>Result is found</b>
    <b>Given</b> I am on the search page
    <b> When</b> I search something
    <b> Then</b> I should see the word result
</pre>


### More Examples

* [READ ALL EXAMPLES](http://github.com/thejamespinto/bdd/tree/master/examples)

<br><br><br><br>




## Customize

By default, Bdd adds the following methods to you `Given`, `When`, `Then`, `And` and `But`.

You may need more! Bdd will help you with that too.

```ruby
# example with words

Bdd.add_language(%w[Given], %w[When Then], %w[And But])

Bdd.add_language(%w[], %w[], %w[AndGiven AndThen ButGiven ButThen])

Bdd.add_language(%w[PreCondition], %w[When], %w[PostCondition])

Bdd.add_language(%w[Backround], %w[When], %w[Expects])

```

```ruby
# example with languages

Bdd.add_language(%w[Given], %w[When Then], %w[And But]) # English

Bdd.add_language(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese

Bdd.add_language(%w[Zakładając], %w[Jeśli To], %w[Także Ale]) # Polish
```




## Authors

* [James Pinto](http://github.com/thejamespinto)



## Contributing

1. Fork it ( https://github.com/thejamespinto/bdd/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Alternatives and Inspiration

* [rspec-steps](https://github.com/LRDesign/rspec-steps)
* [rspec-given](https://github.com/jimweirich/rspec-given)
* [rspec-example_steps](https://github.com/railsware/rspec-example_steps)
* [cucumber](https://github.com/cucumber/cucumber)

<pre>
  <b>rspec-steps</b>, <b>rspec-given</b> and <b>rspec-example_steps</b> run <i>AS</i> examples.
  <b>bdd</b> and <b>cucumber</b> run <i>INSIDE</i> examples, running tests faster.
</pre>
