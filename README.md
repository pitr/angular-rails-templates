# Angular Rails Templates [![Build Status](https://secure.travis-ci.org/pitr/angular-rails-templates.png?branch=master)](http://travis-ci.org/pitr/angular-rails-templates)

Adds your HTML templates into Angular's `$templateCache` using Rails asset pipeline.

It removes the need for AJAX calls to retrieve the templates (or for you to manually set them into the DOM).

## Usage

### 1. Add the gem

In Gemfile

```ruby
gem 'angular-rails-templates'
```

### 2. Include templates in JS

Then, in your `application.js` file, require your templates and the internal javascript file:

```javascript
//= require_tree ./angularjs
//= require_tree ./path_to_your_templates
//= require angular-rails-templates
```


`path_to_your_templates` is relative to `application.js`.  For example, your templates are under `app/assets/javascripts/my_app/templates` and you then `require_tree ./my_app/templates`

Extensions supported are **.html**, **.ajs**, **.nghaml**, **.ngslim**. Last two do additional preprocessing and require `haml` and `slim` gems in your Gemfile.

### 3. Add a dependency in Angular module

Your Angular module needs to have `templates` as a dependency (configurable with `config.angular_templates.module_name`)

```javascript
var application = angular.module('myApplication', ['templates']);
```

Loading this module will automatically load all your templates into angular's `$templateCache`.
Angular uses this parameter when checking for the presence of templates before making an HTTP call.

The templates can then be accessed via `templateUrl` as expected:

``` javascript
{
  templateUrl: 'my_app/templates/yourTemplate.html'
}
```

You can set `config.angular_templates.ignore_prefix` to remove part of the path to your templates. For example, set it to `my_app/templates/` so you can refer to your templates by simply `yourTemplate.html`. Default is `templates/`.

## License

MIT License. Copyright 2014 Pitr

## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
* pitr <pitr.vern@gmail.com>
