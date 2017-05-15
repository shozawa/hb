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

person = Person.new(1, 'shozawa@sample.com', 'shozawa', 'tomohiro', 28)

PersonPresenter.new(person).to_h

# => { id: 1, email: 'shozawa@sample.com', family_name: 'shozawa' }

# you can pass ActiveModel object like this
PersonPresenter.new(User.find(1)).to_h
```

### Computed Attributes
```ruby
class PersonPresenter < Hb::Base
  attributes :id, :email, :full_name
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end

# => { id: 1, email: 'shozawa@sample.com', full_name: 'tomohiro shozawa' }
```

`object` is the object to be wrapped.

### Transforming Keys
```ruby
# pass method_name
Hb::Base.key_format :upcase
PersonPresenter.new(person).to_h
# => { "ID" => 1, "EMAIL" => 'shozawa@sample.com', "FULL_NAME": ... }

# with options
Hb::Base.key_format camelize: :lower
PersonPresenter.new(person).to_h
# => { "id" => 1, "email" => 'shozawa@sample.com', "fullName": ... }

# you can pass proc
Hb::Base.key_format -> (k) { '_' + k }
PersonPresenter.new(person).to_h
# => { "_id" => 1, "_email" => 'shozawa@sample.com', "_full_name": ... }

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hb.

