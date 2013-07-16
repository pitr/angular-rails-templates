# Angular Rails Templates

Behind the hideous Angular Rails Templates name is hiding a template management system for rails' asset pipeline and AngularJS' template views.

Basically: this will precompile your templates into the template cache, to be used by your application.  
It removes the need for ajax calls to get the templates (or for you to manually set them into the dom).

## Usage

Add the gem into your Gemfile

    gem 'angular-rails-templates'

Then, in your `application.js` file, require your templates and the internal javascript file:

    //= require angularjs
    //= require_tree ./path_to_your_templates
    //= require angular-rails-templates

The `require angular-rails-templates` **needs** to happen after requiring all your templates. Otherwise, they won't be loaded.
Your template files can have the extensions **.html** or **.ajs**

In your application, add a dependency to the `templates` module.

## How it works

Because of the way angular's modules work, we cannot create one templates module which would load all the templates.  
Therefore, we create one module per template. It's callsed `templates-<template-name>`.

Also, because we cannot dynamically retrieve a list of all angular modules to find the ones matching our templates and include them, we add a root variable which contains the list of all our templates modules.  
It is `window.AngularRailsTemplates`.

When you `require angular-rails-templates`, we create the `templates` module, which has dependencies to all the templates previously defined. Therefore including all our templates.

## License

MIT License. Copyright 2013 Damien Mathieu


## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
