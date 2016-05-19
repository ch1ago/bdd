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

<br><br><br><br>






## Installation

Include in your Gemfile:

```ruby
group :test do
  # pick one
  gem 'bdd', require: 'bdd/rspec'
  gem 'bdd', require: 'bdd/minitest'
end
```




### Installation For RSpec

```ruby
group :test do
  gem 'rspec'
  gem 'bdd', require: 'bdd/rspec'
end
```

Run specs with custom format specified inline:

`
rspec --format Bdd::RSpec::Formatter --color spec
`

Or, if you want to use as your default formatter, simply put the options in your .rspec file:

`.rspec`

```yml
--format Bdd::RSpec::Formatter
--color
```




### Installation For Minitest

```ruby
group :test do
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'bdd', require: 'bdd/minitest'
end
```

Add this to your `test/test_helper.rb` file.

```ruby
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
```

<br><br><br><br>





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






## Defining custom steps

I case your flow is different and you would like to define your own wording
it can be done with:

```ruby
require "bdd/rspec/example_group_steps"

module ExampleGroupPolish
  include ExampleGroupSteps
  define_bdd_step(*%w[Zakładając Jeśli To]) # Polish versions :)
end

RSpec::Core::ExampleGroup.send :include, ExampleGroupPolish
```

To avoid loading `Given` and the rest, in `Gemfile` change to:

```ruby
gem 'bdd', require: 'bdd/rspec/example_group_steps' # or false
```






## Development

Currently we only support __RSpec__ and __Minitest__

__test_unit__ pull requests are wanted.

__internationalization__ pull requests are wanted.


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
