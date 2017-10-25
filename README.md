[![Build Status](https://travis-ci.org/bacrossland/accounts.svg?branch=master)](https://travis-ci.org/bacrossland/accounts)

# Accounts

The Accounts application reads a transaction log dat file for display and reporting purposes.
The current dat log is located at db/seed_data/data.dat.


### Ruby Version

The ruby version used is 2.4.1. If you are using RVM, .ruby-version and .ruby-gemset 
files are included for ease of installation and operation.

### Database

The application uses a SQLite database.

### Installation and Running

To install and run the application, clone this repository after you have made sure you have ruby 2.4.1 installed 
and the bundle gem installed.

To install the bundle gem run ```gem install bundle```

Run the following commands to install and start this application.

```
   bundle install 
   rails db:setup
   rails server
```
After the server is running, open a webrowser and navigate to the address displayed in the terminal.

### Original Scope

This application was built to answer the questions outlined in the [SCOPE.md](SCOPE.md) file.

## Notes on Amount Storage and Display

The data.dat file contains USD amounts defined as 8 byte (float64). These are stored in the database 
as decimals with a precision of 53 and scale of 17. All math on the amounts is done as decimals and then displayed 
using the number_to_currency method in Rails. The display method simply rounds the amount to two decimal places and 
formats it to display in USD.