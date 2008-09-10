Gem::Specification.new do |s|
  s.name = "oauth"
  s.version = "0.2.7"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pelle Braendgaard", "Blaine Cook", "Larry Halff", "Jesse Clark", "Jon Crosby", "SethFitzsimmons"]
  s.date = %q{2008-04-27}
  s.description = "OAuth Core Ruby implementation"
  s.email = ["pelleb@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = %w(History.txt License.txt Manifest.txt README.txt Rakefile config/hoe.rb config/requirements.rb lib/oauth.rb lib/oauth/client.rb lib/oauth/client/action_controller_request.rb lib/oauth/client/helper.rb lib/oauth/client/net_http.rb lib/oauth/consumer.rb lib/oauth/helper.rb lib/oauth/request_proxy.rb lib/oauth/request_proxy/action_controller_request.rb lib/oauth/request_proxy/base.rb lib/oauth/request_proxy/net_http.rb lib/oauth/request_proxy/rack_request.rb lib/oauth/server.rb lib/oauth/signature.rb lib/oauth/signature/base.rb lib/oauth/signature/hmac/base.rb lib/oauth/signature/hmac/md5.rb lib/oauth/signature/hmac/rmd160.rb lib/oauth/signature/hmac/sha1.rb lib/oauth/signature/hmac/sha2.rb lib/oauth/signature/md5.rb lib/oauth/signature/plaintext.rb lib/oauth/signature/rsa/sha1.rb lib/oauth/signature/sha1.rb lib/oauth/token.rb lib/oauth/version.rb script/destroy script/generate script/txt2html setup.rb tasks/deployment.rake tasks/environment.rake tasks/website.rake test/test_action_controller_request_proxy.rb test/test_consumer.rb test/test_helper.rb test/test_hmac_sha1.rb test/test_net_http_client.rb test/test_net_http_request_proxy.rb test/test_rack_request_proxy.rb test/test_signature.rb test/test_signature_base.rb test/test_token.rb website/index.html website/index.txt website/javascripts/rounded_corners_lite.inc.js website/stylesheets/screen.css website/template.rhtml test/test_server.rb)
  s.test_files = %w(test/test_action_controller_request_proxy.rb test/test_consumer.rb test/test_helper.rb test/test_hmac_sha1.rb test/test_net_http_client.rb test/test_net_http_request_proxy.rb test/test_rack_request_proxy.rb test/test_server.rb test/test_signature.rb test/test_signature_base.rb test/test_token.rb)
  s.has_rdoc = true
  s.homepage = %q{http://oauth.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{oauth}
  s.rubygems_version = %q{1.2.0}
  s.summary = "OAuth Core Ruby implementation"

  s.add_dependency("ruby-hmac", [">= 0.3.1"])
end
