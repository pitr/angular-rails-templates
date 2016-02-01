require 'test_helper'

# Test the "user" templates in the Dummy app

describe "user assets integration" do
  let(:config) { Dummy::Application.config.angular_templates }

  describe "any rendered template" do

    before { visit '/assets/plain.js' }

    it "has a comment with the gem name" do
      page.source.must_match   %r{// Angular Rails Template}
    end

    it "has a comment with the source file" do
      page.source.must_include %Q{// source:}
    end

    it "opens an existing angular module" do
      page.source.must_include %Q{angular.module("#{config.module_name}")}
    end

    it "puts something in the templateCache" do
      page.source.must_include %Q{$templateCache.put}
    end
  end

  describe "templates in assets/javascript" do

    # xit "compiles erb (erb_template.html.erb)" do
    #   visit '/assets/erb_template.js'
    #   page.source.must_include %Q{// source: app/assets/javascripts/erb_template.html.erb}
    #   page.source.must_include %Q{$templateCache.put("erb_template.html"}
    #   page.source.must_include %q{'<div class="hello-world">42</div>'}
    # end

    # assuming the user loads haml
    it "compiles haml (haml_template.html.haml)" do
      visit '/assets/haml_template.js'
      page.source.must_include %Q{// source: app/assets/javascripts/haml_template.nghaml}
      page.source.must_include %Q{$templateCache.put("haml_template.html"}
      page.source.must_include %q{"<h1>html-haml</h1>}
    end

    # assuming the user loads an approperate md library
    # xit "compiles markdown (markdown.html.md)" do
    #   visit '/assets/markdown.js'
    #   page.source.must_include %Q{// source: app/assets/javascripts/markdown.html.md}
    #   page.source.must_include %Q{$templateCache.put("markdown.html"}
    #   page.source.must_match   %r{<h3.+>Markdown!</h3>}
    # end

    it "compiles plain html (plain.html)" do
      visit '/assets/plain.js'
      page.source.must_include %Q{// source: app/assets/javascripts/plain.nghtml}
      page.source.must_include %Q{$templateCache.put("plain.html"}
      page.source.must_include %q{'<div class="hello-world">plain text</div>'}
    end

    # assuming the user loads slim
    # xit "compiles slim (slim_template.html.slim)" do
    #   visit '/assets/slim_template.js'
    #   page.source.must_include %Q{// source: app/assets/javascripts/slim_template.html.slim}
    #   page.source.must_include %Q{$templateCache.put("slim_template.html"}
    #   page.source.must_include %q{"<h1>slim template</h1>"}
    # end
  end

  # describe "templates in assets/javascript/ignored_namespace" do
  #
  #   it "is configured with a custom namespace" do
  #     assert_equal config.ignore_prefix.count, 1
  #     assert_match config.ignore_prefix[0], "ignored_namespace/"
  #   end
  #
  #   xit "compiles haml (slim_template.html.slim)" do
  #     visit '/assets/slim_template.js'
  #     page.source.must_include %Q{// source: app/assets/javascripts/slim_template.html}
  #     page.source.must_include %Q{$templateCache.put("slim_template.html"}
  #     page.source.must_include %q{"<h1>slim template</h1>"}
  #   end
  # end

  describe "templates in assets/javascript/subfolder" do

    it "compiles html in a subfolder (template.html)" do
      visit '/assets/subfolder/template.js'
      page.source.must_include %Q{// source: app/assets/javascripts/subfolder/template.nghtml}
      page.source.must_include %Q{$templateCache.put("subfolder/template.html"}
      page.source.must_include %q{'<div class="hello-world">Subfolder</div>}
    end

    # it "compiles slim in a subfolder (slim_template.html.slim)" do
    #   visit '/assets/subfolder/slim_template.js'
    #   page.source.must_include %Q{// source: app/assets/javascripts/subfolder/slim_template.html.slim}
    #   page.source.must_include %Q{$templateCache.put("subfolder/slim_template.html"}
    #   page.source.must_include %q{'<div class="hello-world">Subfolder-SLIM</div>'}
    # end

    it "compiles haml in a subfolder (haml_template.html.haml)" do
      visit '/assets/subfolder/haml_template.js'
      page.source.must_include %Q{// source: app/assets/javascripts/subfolder/haml_template.nghaml}
      page.source.must_include %Q{$templateCache.put("subfolder/haml_template.html"}
      page.source.must_include %q{"<div class='hello-world'>Subfolder-HAML</div>}
    end
  end

  describe "templates in assets/javascript/subfolder2" do

    it "compiles html in a subfolder (template.html)" do
      visit '/assets/subfolder2/template.js'
      page.source.must_include %Q{// source: app/assets/javascripts/subfolder2/template.nghtml}
      page.source.must_include %Q{$templateCache.put("subfolder2/template.html"}
      page.source.must_include %q{'<div class="hello-world">Subfolder2</div>}
    end
  end

  # NOT in assets/javascript
  describe "templates in assets/templates" do

    it "compiles html (test.html)" do
      visit '/assets/test.js'
      page.source.must_include %Q{// source: app/assets/templates/test.nghtml}
      page.source.must_include %Q{$templateCache.put("test.html"}
      page.source.must_include %q{"outside-javascript"}
    end

    # it "compiles str (sub/sub.html.str)" do
    #   visit '/assets/sub/sub.js'
    #   page.source.must_include %Q{// source: app/assets/templates/sub/sub.html.str}
    #   page.source.must_include %Q{$templateCache.put("sub/sub.html"}
    #   page.source.must_include %q{"outside-javascript 42"}
    # end

    it "compiles haml (sub2.html.haml)" do
      visit '/assets/sub/sub2.js'
      page.source.must_include %Q{// source: app/assets/templates/sub/sub2.nghaml}
      page.source.must_include %Q{$templateCache.put("sub/sub2.html"}
      page.source.must_include %q{"<p>P.S. I love you</p>}
    end
  end

end
