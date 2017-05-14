# Hb

Simple Hash Builder which has ActiveModelSerializers like interface.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hb

## Usage

### Creating Presenter
Subclass Hb::Base and declare attributes.

```ruby
class PersonPresenter < Hb::Base
  attributes :id, :email
  attribute :last_name, key: :family_name
end
```
The attributes names are whitelist of attributes to be exposed. You can change key name by using :key option.

### Buildeing Hash

```ruby
Person = Struct.new(:id, :email, :last_name, :first_name, :age)

shozawa = Person.new(1, 'shozawa@sample.com', 'shozawa', 'tomohiro', 28)

PersonPresenter.new(shozawa).to_h

# => { id: 1, email: 'shozawa@sample.com', family_name: 'shozawa' }
```

### Using method
```ruby
class PersonPresenter < Hb::Base
  attributes :id, :email, :full_name
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end

# => { id: 1, email: 'shozawa@sample.com', full_name: 'tomohiro shozawa' }
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hb.

