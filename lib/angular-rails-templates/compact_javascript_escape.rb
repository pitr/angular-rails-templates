module AngularRailsTemplates
  module CompactJavaScriptEscape
    # inspired by Rails' action_view/helpers/javascript_helper.rb
    JS_ESCAPE_MAP = {
      '\\'    => '\\\\',
      "\r\n"  => '\n',
      "\n"    => '\n',
      "\r"    => '\n',
      '"'     => '\\"',
      "'"     => "\\'"
    }

    # We want to deliver the shortist valid javascript escaped string
    # Count the number of " vs '
    # If more ', escape "
    # If more ", escape '
    # If equal, prefer to escape "

    def escape_javascript(raw)
      if raw
        quote = raw.count(%{'}) >= raw.count(%{"}) ? %{"} : %{'}
        escaped = raw.gsub(/(\\|\r\n|[\n\r#{quote}])/u) {|match| JS_ESCAPE_MAP[match] }
        "#{quote}#{escaped}#{quote}"
      else
        '""'
      end
    end
  end
end
