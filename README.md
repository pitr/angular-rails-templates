# Angular Rails Templates [![Build Status](https://secure.travis-ci.org/pitr/angular-rails-templates.png?branch=master)](http://travis-ci.org/pitr/angular-rails-templates)

Adds your HTML templates into Angular's `$templateCache` using Rails asset pipeline.

It removes the need for AJAX calls to retrieve the templates (or for you to manually set them into the DOM).

## Usage

### 1. Add the Gem

In Gemfile

```ruby
gem 'angular-rails-templates'
```

### 2. Include Templates in Rails Asset Pipeline

Then, in your `application.js` file, require your templates and the internal javascript file:

```javascript
//= require angularjs
//= require angular-rails-templates
//= require_tree ./templates
```

Make sure to require `angular-rails-templates` before you require your templates.

`templates` is relative to `application.js`.  For example, if your templates are under `app/assets/javascripts/my_app/templates` then you should `require_tree ./my_app/templates`


Extensions supported are **.html**, **.ajs**, **.nghaml**, **.ngslim**. Last two do additional preprocessing and require `haml` and `slim` gems in your Gemfile.

### 3. Add a Dependency in your Angular Application Module

Your Angular module needs to have `templates` as a dependency (configurable with `config.angular_templates.module_name`)

```javascript
var application = angular.module('myApplication', ['templates']);
```

Loading this module will automatically load all your templates into angular's `$templateCache`.
Angular uses this parameter when checking for the presence of templates before making an HTTP call.

### 4. Use your Templates

No matter what the source file extension is, your template's url will be  `#{base_name}.html`

For example:
```
main.html => main.html
widget.nghaml => widget.html
modals/confirm.ngslim => modals/confirm.html
```

The default template location is `app/assets/javascripts/templates`. Angular Rails Templates will remove `templates/` from the `templateUrl` it reports to angularjs. If your templates are not in this location, you will need to use the full path to the template.

You can set `config.angular_templates.ignore_prefix` to change the default template location. Default is `templates/`.

The templates can then be accessed via `templateUrl` as expected:

``` javascript
// Templates in: app/assets/javascripts/templates (default)
// ignore_prefix: templates/ (default)
{
  templateUrl: 'yourTemplate.html'
}
// This won't work:
{
  templateUrl: 'templates/yourTemplate.html'
}
```

``` javascript
// Templates in: app/assets/javascripts/my_app/templates (custom)
// ignore_prefix: templates/ (default)
{
  templateUrl: 'my_app/templates/yourTemplate.html'
}

// ignore_prefix: my_app/templates/ (custom)
{
  templateUrl: 'yourTemplate.html'
}
```

## License

MIT License. Copyright 2014 Pitr

## Authors & contributors

* Damien Mathieu <42@dmathieu.com>
* pitr <pitr.vern@gmail.com>
