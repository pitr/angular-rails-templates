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

## License

MIT License. Copyright 2013 Damien Mathieu


## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
