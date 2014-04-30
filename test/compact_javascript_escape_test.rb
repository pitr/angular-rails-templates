require 'test_helper'
require 'angular-rails-templates/compact_javascript_escape'

describe AngularRailsTemplates::CompactJavaScriptEscape do
  let(:instance) do
    Class.new { include AngularRailsTemplates::CompactJavaScriptEscape }.new
  end

  it "responds to :escape_javascript" do
    instance.must_respond_to :escape_javascript
  end

  describe "#escape_javascript" do

    it "returns strings" do
      instance.escape_javascript("hello").must_be_kind_of String
      instance.escape_javascript("").     must_be_kind_of String
      instance.escape_javascript(nil).    must_be_kind_of String
    end

    it "uses double quotes to wrap strings without quotes" do
      str = instance.escape_javascript("hello")
      str[0].must_equal str[-1]
      str[0].must_equal %(")
    end

    it "uses double quotes to wrap strings with many single quotes" do
      str = instance.escape_javascript(%{'hello'})
      str[0].must_equal str[-1]
      str[0].must_equal %(")
    end

    it "uses single quotes to wrap strings with many double quotes" do
      str = instance.escape_javascript(%{"hello"})
      str[0].must_equal str[-1]
      str[0].must_equal %(')
    end

    it "escapes single quotes when double quotes are used to wrap strings" do
      str = instance.escape_javascript(%{'h'e"l'lo'})
      str[0].must_equal %(")
      str.must_match %{\\"}
      str.wont_match %{\\'}
    end

    it "escapes double quotes when single quotes are used to wrap strings" do
      str = instance.escape_javascript(%{"h"e'l"lo"})
      str[0].must_equal %(')
      str.must_match %{\\'}
      str.wont_match %{\\"}
    end

    it "escapes backslashes" do
      str = instance.escape_javascript(%{a\\z})
      str.must_match %{a\\\\z}
    end
  end
end
