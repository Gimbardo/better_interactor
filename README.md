# BetterInteractor

Better Interactor is a gem that aims to extend the default usage for the [Interactor](https://github.com/collectiveidea/interactor) gem. The default Interactor usage is unchanged, extended with new possibilities:

- adding a condition to your interactors, in the organizer, to skip its call, if that returns false
- defining a default condition for each interactor call, in the organizer
- [UNDER DEVELOPMENT] defining a method inside the organizer and call that instead of an organizer

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add better_interactor
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install better_interactor
```

## Usage

### Conditional Call

passing an hash instead of and interactor allows you to define 2 keys inside of it:

- class: with the interactor class name
- if: with a symbol with the same name as the method that responds to our condition

``` ruby
class PlaceOrder
  include Interactor::Organizer

  def should_send_thank_you?
    context.client.is_a_good_client?
  end

  organize CreateOrder,
           { class: ChargeCard }
           { class: SendThankYou, if: :should_send_thank_you? }
end
```

In this example:

- CreateOrder will always be called, because you passed only the class
- ChargeCard will always be called, because there's no "if"
- SendThankYou will be called only if the method should_send_thank_you?, with the passed context, returns true

### Default Condition

This grants a default condition name for the method to call, defined as follows:
"can_[interactor class name underscored]?"

``` ruby
class PlaceOrder
  include Interactor::Organizer

  def can_send_thank_you?
    context.client.is_a_good_client?
  end

  organize CreateOrder,
           { class: ChargeCard }
           { class: SendThankYou }
end
```

In this example:

- CreateOrder will always be called, because you passed only the class
- ChargeCard will always be called, because there's no method named **can_charge_card?**
- SendThankYou will be called only if the method **can_send_thank_you?**, with the passed context, returns true

**In case of Interactors inside of Modules (Client::SendThanksYou) the modules are included inside the method name (can_client_send_thanks_you?)**

### Interactor-like method

If you feel like an interactor, sometimes, is too much for a small non-reusable piece of logic, you can define a method
and use it as an interactor, just pass a symbol with the method name as you would with a normal interactor

``` ruby
class PlaceOrder
  include Interactor::Organizer

  def create_order
    Order.create(context.order_attr)
  end

  def send_thank_you
    Email.new(to: context.client.email, content: "thanks :D")
  end

  organize :create_order,
           { class: :send_thank_you }
end
```

In this example we use 0 Interactors, and rely only on methods.

**Conditional logic defined above still applies!!!**

## Development

Clone this repo, run bundle and you are good to go.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gimbardo/better_interactor.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
