## Changelog

### [Unreleased]

### 1.0.2

- Silence deprecation warning on sprockets 3.7 [kressh, #145]

### 1.0.1

- Better support for Rails 5 and Sprockets 4 [merqlove/sandrew, #142]

### 1.0.0

- Add support for Rails 5.0 [pitr, #131]

### 1.0.0.beta2

- Loading tilt gem before using
- Configurable extension `.html` [speranskydanil, #99]
- Default inside_paths is a relative path [redterror, #108]
- Do not process files outside inside_paths path [keenahn, #113]

### 1.0.0.beta1

- Add support for Rails 4.2 [superchris/pitr, #126]
- Remove support for Rails 4.1 and less

### 0.2.0

- Add config.angular_templates.inside_paths [sars, #90]

### 0.1.5

- Lock Sprocket support to version 2 [davetron5000, #96]

### 0.1.4

- Run when `initialize_on_precompile = false` [squirly, #84]

### 0.1.3

- Add array support to config.angular_templates.ignore_prefix [AaronV, #54]
- Compatibility with slim-rails 2.1.5 [blackxored, #57]

### 0.1.2

- Automatic Sprockets Cache busting (+ tilt warning silence) [whitehat101, #48]

### 0.1.1

- Add vendor folder to gemspec [whitehat101, #41]
- Add Tilt as dependency [pitr, #43]

### 0.1.0

- **BREAKING** Bring back a separate JS file for module declaration [whitehat101, #35]
- Fix Rails 4 support [brianewing, #39]
- Add Tilt support [whitehat101, #38]
- Add Template Chaining e.g. `example.html.haml.erb` [whitehat101, #38]
- Add HtmlCompressor [whitehat101, #38]

### 0.0.7

- Add support for HAML and SLIM templates [oivoodoo, #26]

### 0.0.6

- Fix for Rails 4 [pitr, #20]

### 0.0.5 (yanked)

- Support Rails 3.2+ (in addition to Rails 4) [pitr, #14]

### 0.0.4

- Deprecate need for angular-rails-templates.js (pitr, #9)
- Add ignore_prefix (pitr, #7)
