# Google Places Autocomplete (using Typhoeus instead)

Ruby wrapper for the [Google Places Autocomplete API](http://code.google.com/apis/maps/documentation/places/autocomplete.html).

This is a fork from [phuphighter/google_places_autocomplete](https://github.com/phuphighter/google_places_autocomplete)

HTTParty gem was removed and I'm using Typhoeus for faster HTTP requests.
The changes in the code were only workarounds to make Typhoeus work, so I don't really know what consequences those changes may have.

## Installation

Inside your Gemfile:   
gem 'google_places_autocomplete', :git => 'http://github.com/samirph/google_places_autocomplete.git'

## Get Google Places API credentials

Go here and activate it:   
[https://code.google.com/apis/console](https://code.google.com/apis/console)

## Usage

### Instantiate a client

    >> client = GooglePlacesAutocomplete::Client.new(:api_key => 'your_api_key')

#### Example

    >> autocomplete = client.autocomplete(:input => "Paris", :types => "geocode")
    >> autocomplete.predictions.first.description
    => "Paris, France"

## Copyright

Copyright (c) 2009 Johnny Khai Nguyen, released under the MIT license
