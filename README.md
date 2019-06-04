# ruby_coding_project

## Requirements

* ruby (2.6)
* postgresql (9.4+)

## Setup instructions

* Navigate to server_code directory

```
cd server_code
```

* Install dependencies

```
bundle install
```

* Create the database, run migrations and add seed data

```
bundle exec rake db:setup
```

* Start the application

```
./start.sh
```

* Run unit tests

```
bundle exec rspec
```

* For command line access of the application through console:

```
irb
> require './api.rb'
```
