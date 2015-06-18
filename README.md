## Bdd

Bdd brings cucumber-style Given/When/Then/And/But steps for RSpec examples

### Status

[![Gem Version](https://badge.fury.io/rb/bdd.svg)](http://badge.fury.io/rb/bdd)
[![Build Status](https://travis-ci.org/thejamespinto/bdd.svg)](https://travis-ci.org/thejamespinto/bdd)

### Description

This gem brings two major functionality to your tests

* Verbosity for rspec documentation formatter.
* Ability to comment or describe set of actions in example into some step.



## Installation

Include in your Gemfile:

```ruby
group :test do
  gem 'bdd'
end
```

### RSpec

Run specs with custom format specified inline:
```
rspec --format Bdd::RSpec::Formatter --color spec
```

Or, if you want to use as your default formatter, simply put the options in your .rspec file:
```
--format Bdd::RSpec::Formatter
--color
```

## Output Example

`spec/features/search_spec.rb`

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


### Documentation formatting output:

`rspec -fd spec/features/search_spec.rb`

<pre>
<b>Searching</b>
  <b>Result is found</b>
    <b>Given</b> I am on the search page
    <b> When</b> I search something
    <b> Then</b> I should see the word result
</pre>



### Shared Steps

### Basic Example with shared steps

You can refactor steps into methods using plain Ruby syntax.

```ruby
def given_I_log_in
  Given "I log in" do
    visit '/login'
    fill_in 'Login', with: 'jack@example.com'
    fill_in 'Password', with: 'password'
    click_button "Log in"
    expect(page).to have_content('Welcome jack@example.com')
  end
end

def then_I_should_see_a_confirmation_message
  Then "I should see a confirmation message" do
    expect(page).to have_content('Your profile was updated successfully')
  end
end

context 'User Flow' do
  it 'User updates profile description' do
    given_I_log_in
    When 'I update profile description' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end

  it 'User updates profile avatar' do
    given_I_log_in
    When 'I update profile avatar' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end
end
```
Output:
<pre>
<b>User Flow</b>
  <b>User updates profile description</b>
    <b>Given</b> I log in
    <b> When</b> I update profile description
    <b> Then</b> I should see a confirmation message
</pre>


### Nested Example with shared steps

Nesting will silence any output from the internal steps

```ruby
def given_I_am_on_the_log_in_page
  Given 'I am on the login page' do
    visit '/login'
  end
end

def when_I_submit_the_log_in_form
  When 'I put credentials' do
    fill_in 'Login', with: 'jack@example.com'
    fill_in 'Password', with: 'password'
    click_button "Log in"
  end
end

def then_I_should_be_logged_in
  Then 'I should be logged in' do
    expect(page).to have_content('Welcome jack@example.com')
  end
end

def given_I_log_in
  Given "I log in" do
    given_I_am_on_the_log_in_page
    when_I_submit_the_log_in_form
    then_I_should_be_logged_in
  end
end

context 'User Flow' do
  it 'User updates profile description' do
    given_I_log_in
    When 'I update profile description' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end

  it 'User updates profile avatar' do
    given_I_log_in
    When 'I update profile avatar' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end
end
```
Output:
<pre>
<b>User Flow</b>
  <b>User updates profile description</b>
    <b>Given</b> I log in
    <b> When</b> I update profile description
    <b> Then</b> I should see a confirmation message
</pre>


### Renaming

Useful for refactored nesting, you can change a step's name

```ruby
def when_I_log_in
  When "I log in" do
    visit '/login'
    fill_in 'Login', with: 'jack@example.com'
    fill_in 'Password', with: 'password'
    click_button "Log in"
    expect(page).to have_content('Welcome jack@example.com')
  end
end


def given_I_log_in
  Given when_I_log_in
end

context 'User Flow'
  it 'User updates profile description' do
    given_I_log_in
    When 'I update profile description' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end

  it 'User updates profile avatar' do
    given_I_log_in
    When 'I update profile avatar' do
      ...
    end
    then_I_should_see_a_confirmation_message
  end
end
```
Output:
<pre>
<b>User Flow</b>
  <b>User updates profile description</b>
    <b>Given</b> I log in
    <b> When</b> I update profile description
    <b> Then</b> I should see a confirmation message
</pre>







## Development

Currently we only support __RSpec__

__minitest__ and __test_unit__ pull requests are wanted.

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
