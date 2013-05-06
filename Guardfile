# A Guardfile
# More info at https://github.com/guard/guard#readme

group :livereload do
  guard 'livereload', apply_js_live: false do
    watch(%r{app/views/.+\.(erb|haml|rabl|slim)})
    watch(%r{^(app|lib)/.+\.rb})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)/assets/\w+/([^.].+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
    watch(%r{(app|vendor)/assets/images/(.*)})  { |m| "/assets/#{m[2]}" }
  end
end
