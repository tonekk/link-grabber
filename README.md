CoMpharmed
==========

Veredeln sie ihr CRM!

## Rails.

We are using a Rails/MongoDB combo, as well as the following Gems:

* devise for Authentication
* carrierwave for FileUpload
* roo for Excel Processing
* sidekiq & clockwork for Background Jobs
* geocoder for Geocoding
* pry for Debugging


### Testing

The Testsuite contains Minitest and Capybara/Poltergeist for Integration tests.
Press
```
rake
```
to run the Tests.
Tests should be green before deploying!
Continous testing & deployment to come.
