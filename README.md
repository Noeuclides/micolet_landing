# Micolet Landing

## Installation

1) Clone this repository

2) And then execute the following command from root project for install ruby dependencies

```bash
$ bundle install
```

## Usage

### Set up environment

1) Set up database

Create and Run migrations in database with following Rails tasks:

* `db:drop`(optional): delete project database if exist.
* `db:create`: create project database.
* `db:migrate`: run migrations of the folder `sy_app/db/migrate`.
* `db:test:prepare`: run migrations of the folder `sy_app/db/migrate`on the test environment.

The above Rails tasks can be executed in a single instruction:

```bash
$ rails db:drop db:create db:migrate db:test:prepare
```

2) Create a .env file and set your ABSTRACT_API_KEY. You MUST create an account in [ABSTRACTAPI!](https://app.abstractapi.com/api/email-validation/documentation).

3) Run seeds
```bash
$ rails db:seed --trace
```

4) Run rails server
```bash
$ rails s
```

To Run specs

```bash
$ bundle exec rspec
```
