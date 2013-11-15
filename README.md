# Angular Rails Templates [![Build Status](https://secure.travis-ci.org/dmathieu/angular-rails-templates.png?branch=master)](http://travis-ci.org/dmathieu/angular-rails-templates)

Behind the hideous Angular Rails Templates name is hiding a template management system for rails' asset pipeline and AngularJS' template views.

Basically: this will precompile your templates into the template cache, to be used by your application.
It removes the need for ajax calls to get the templates (or for you to manually set them into the dom).

## Usage

Add the gem into your Gemfile

```ruby
gem 'angular-rails-templates'
```

Then, in your `application.js` file, require your templates and the internal javascript file:

```javascript
//= require angularjs
//= require_tree ./path_to_your_templates
```

Your template files can have the extensions **.html** or **.ajs**

In your application, add a dependency to the `templates` module.

```javascript
var application = angular.module('myApplication', ['templates']);
```

Loading this module will automatically load all your templates into angular's `$templateCache`.
Angular uses this parameter when checking for the presence of templates before making an HTTP call.

## How it works

We create the `templates` module (configurable through `config.angular_templates.module_name` in your application.rb), which populates Angular's `$templateCache` with all your templates when the module is included in your app.

## License

MIT License. Copyright 2013 Damien Mathieu

## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
* pitr <pitr.vern@gmail.com>
