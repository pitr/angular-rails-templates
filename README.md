# Angular Rails Templates [![Build Status](https://secure.travis-ci.org/dmathieu/angular-rails-templates.png?branch=master)](http://travis-ci.org/dmathieu/angular-rails-templates)

Behind the hideous Angular Rails Templates name is hiding a template management system for rails' asset pipeline and AngularJS' template views.

Basically: this will precompile your templates into the template cache, to be used by your application.
It removes the need for ajax calls to get the templates (or for you to manually set them into the dom).

## Usage

Add the gem into your Gemfile

    gem 'angular-rails-templates', github: 'luckyjazzbo/angular-rails-templates'

Then, in your `application.js` file, require your templates and the internal javascript file:

    //= require angularjs
    //= require_tree ./path_to_your_templates

Your template files can have the extensions **.html** or **.ajs**


In your application, add a dependency to the `templates` module, like so:

    angular.module("MyApp", ["templates"])

## Main difference from original gem

This fork uses actual file names with paths as keys, this is the only difference.

You can change location of your templates folder in your initializers:

    Rails.configuration.angular_templates.templates_dir = "angular/templates"

by default `angular/templates` folder is used. `templates_dir` will be trimmed for all angularjs template keys.

You can also change angularjs module name:

    Rails.configuration.angular_templates.module_name = "templates"

## License

MIT License. Copyright 2013 Damien Mathieu


## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
* Roman <luckyjazzbo@gmail.com>

