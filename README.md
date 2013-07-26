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


In your application, add a dependency to the `templates` module.

## Main difference from original gem

This fork uses actual file names with paths as keys, this is the only difference.

You can change location of your templates folder like so:

    config.templates_dir = "path/to/my/templates"

by default "angular/templates" is used.

## License

MIT License. Copyright 2013 Damien Mathieu


## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
