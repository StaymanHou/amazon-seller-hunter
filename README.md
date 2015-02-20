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
*TO-DO*

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
