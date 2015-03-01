## Welcome to Amazon Seller Hunter
Amazon Seller Hunter is a Saas application that finds the best seller for any given paperback book (identified by ISBN). Users simply provide ISBN and desired condition (New/Used). Then the application will search for sellers on Amazon and return a best seller for that book based on a rule engine. The rule engine is primarily composed of a set of rules. Each rule filters/scores sellers according to certain criteria. This application comes with a default rule set. Users will be able adjust the threshold value of each rule. Meanwile, developer will be able create/modify rules.

#### The Default Rule Set
* base score = price + shipping fee (if price < $35 then $4.98 else $0 for prime)
* must positive >= 90%
* must total rating >= 100
* must be in stock

#### The Rule Engine
The rule engine filters/scores each seller with the rules. Finally, it returns the seller with the lowest score. If there are multiple sellers with the lowest score, it returns one of them randomly.

#### Developing the Rules
It's easy to create your custom rules. Simply create a subclass of the `RuleProto` class and overwrite the #filter(seller) or #score(seller) or both methods depending on your needs. Place the `.rb` file in the `lib/rules/` directory. Follow the Rails naming convention. For example, we want to create a rule that filters the sellers who don't ship the product from a given country. Let's call it `must_ship_from_the_country_rule`. You also need to create a seed record in database with the name and the default settings.
#### Example
```ruby
# lib/rules/must_ship_from_the_country_rule.rb
class MustShipFromTheCountryRule < RuleProto
  def filter(seller)
    @seller = seller
    if from_the_country?
      return false
    else
      return true
    end
  end
  
  private
  
  def from_the_country?
    @seller.ships_from.downcase.include? @settings['country'].downcase
  end
end
```

```ruby
# db/seeds.rb

# other rule default settings
...

Rule.create(
  name: 'must_ship_from_the_country_rule',
  enabled: true,
  settings: { 'country': 'United States' } # the values must be string
)
```
The rule engine will pass in the `seller` one by one. Check the documentation below to learn all the available attributes of each `seller` object.

The `#filter(seller)` method should return `true` if you want to kick out the seller, otherwise return `false`.

You can use `@settings` in your class (defined in the `db/seeds.rb`). It is a hash. Both keys & values must be strings. **Remember**: user will be able to change the value of the settings, but the keys will always persist.

###### Documentation

* `RuleProto` class
  * `@settings` A hash. Always equal to the `settings` you defined in `db/seeds.rb`. User will be able to change the value of the settings, but the key will always persist.
  * `#filter(seller)` Returns a boolean. Return `true` if you want to filter the seller, otherwise return `false`. Will not filter any seller if you don't overwrite the method.
  * `#score(seller)` Returns a number. Return `1` if you don't want to change the score of the seller. This is the default behaviour if you don't overwrite the method. Return `0` ~ `1` if you want to vote up the seller. The more the number closes to `0`, the more likely it will be picked as the best seller. Return any number > `1` if you want to vote down the seller.

* `seller` object
  * `name` A string. The name of the seller - for example `'staymanshop'`
  * `id` A string. The Amazon ID of the seller - for example `'AGLPMRINU0Q3T'`
  * `price` A number. The price of the product - for example `14.12`
  * `shipping_fee` A number. The fee for shipping - for example `3.99`
  * `prime` A boolean. The product is prime or not - for example `false`
  * `free_shipping_over` A number or `nil`. Shipping fee will be waived if the price is over this number. `nil` if there's no free shipping at all - for example `35`
  * `rate` A number. The percentage of positive customer rating - for example `0.9`
  * `total_ratings` A number. The number of customers rated the seller - for example `10_000`
  * `in_stock` A boolean. Whether the product is in stock - for example `true`
  * `ships_from` A string. The state name and country where the product will be shipped from - for example `'CA, United States'`

* `Rule#create(name, enabled, settings)` method *-- (in db/seeds.rb)*
  * `name` A snakecase string indicates the name of your rule - for example 'must_ship_from_the_country_rule' **(MUST match your `lib/rules/*.rb` file name)**
  * `enabled` A boolean indicates your rule will be enabled or not by default - for example true
  * `settings` A hash whose keys and values MUST be string. **(Use a empty hash even if you don't need any settings)**

## installation
#### Prerequisites
* Virtualbox - https://www.virtualbox.org/wiki/Downloads
* Vagrant - https://www.vagrantup.com/downloads.html
* Git

#### Building
First, make sure you have the box "ubuntu/trusty64" in your vagrant box list. Run `vagrant box list` and verify whether "ubuntu/trusty64" is already there.

If you don't have "ubuntu/trusty64", add it by running the command:
`vagrant box add ubuntu/trusty64` - (command may vary, depending on your vagrant version)

Now, go to the directory in which you want to install Amazon Seller Hunter. `cd /path/to/amazon_seller_hunter`

Clone the project. `git clone https://github.com/StaymanHou/amazon-seller-hunter.git .`

Bootstrap the virtual machine in which the application will run. Run `vagrant up`. The first time you bootstrap it, it will take a few minutes to setup the environment.

When you finished using the application. Run `vagrant halt` to shut down the virtual machine.

## Usage
If it your first time booting the box, once the virtual machine is up, you will be able to access the WebUI via http://192.168.33.19:8080 .
After the first time, you will need to run the following commands after your box booting up.
```
bundle exec sidekiq -d high,5 default -e production
bundle exec unicorn -D -E production
```

## Contributing
We encourage you to contribute to Amazon Seller Hunter! Before you make any pull request, please execute the commands below and make sure all tests pass.

```
cd /path/to/amazon/seller/hunter
vagrant up
vagrant ssh
cd src
bundle exec rubocop
bundle exec rspec
bundle exec cucumber
bundle exec brakeman
vagrant halt
```
