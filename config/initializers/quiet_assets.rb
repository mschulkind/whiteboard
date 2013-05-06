Rails.application.assets.logger = Logger.new('/dev/null')
Rails::Rack::Logger.class_eval do
 protected
  alias_method :call_app_without_quiet_assets, :call_app
  def call_app(request, env)
    if env['PATH_INFO'] =~ /assets/
      @app.call(env)
    else
      call_app_without_quiet_assets(request, env)
    end
  end
end
