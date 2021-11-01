# Ruby OAuth

## Status

| Project                    |  Ruby Oauth                |
|--------------------------- |--------------------------- |
| name, license, docs        |  [![RubyGems.org](https://img.shields.io/badge/name-oauth-brightgreen.svg?style=flat)][rubygems] [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][license-ref] [![RubyDoc.info](https://img.shields.io/badge/documentation-rubydoc-brightgreen.svg?style=flat)][documentation] |
| version & downloads        |  [![Version](https://img.shields.io/gem/v/oauth.svg)][rubygems] [![Downloads Today](https://img.shields.io/gem/rd/oauth.svg)][rubygems] [![Homepage](https://img.shields.io/badge/source-github-brightgreen.svg?style=flat)][source] |
| dependencies & linting     |  [![Depfu](https://badges.depfu.com/badges/d570491bac0ad3b0b65deb3c82028327/count.svg)][depfu] [![lint status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/style.yml/badge.svg)][actions] |
| unit tests                 |  [![supported rubies](https://github.com/oauth-xx/oauth-ruby/actions/workflows/supported.yml/badge.svg)][actions] [![unsupported status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/unsupported.yml/badge.svg)][actions] |
| coverage & maintainability |  [![Test Coverage](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/test_coverage)][climate_coverage] [![codecov](https://codecov.io/gh/oauth-xx/oauth-ruby/branch/master/graph/badge.svg?token=4ZNAWNxrf9)][codecov_coverage] [![Maintainability](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/maintainability)][climate_maintainability] |
| resources                  |  [![Discussion](https://img.shields.io/badge/discussions-github-brightgreen.svg?style=flat)][gh_discussions] [![Mailing List](https://img.shields.io/badge/group-mailinglist-violet.svg?style=social&logo=google)][mailinglist] [![Join the chat at https://gitter.im/oauth-xx/oauth-ruby](https://badges.gitter.im/Join%20Chat.svg)][chat] [![Blog](https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat)][blogpage] |
| Spread ~♡ⓛⓞⓥⓔ♡~         |  [![Open Source Helpers](https://www.codetriage.com/oauth-xx/oauth-ruby/badges/users.svg)][code_triage] [![Liberapay Patrons](https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay)][liberapay_donate] [🌏][aboutme] [👼][angelme] [💻][coderme] [🌹][politicme] [![Tweet @ Peter][followme-img]][tweetme] |

## What

This is a RubyGem for implementing both OAuth 1.0 clients and servers in Ruby
applications.

See the OAuth 1.0 spec http://oauth.net/core/1.0/

See the sibling gem [oauth2](https://github.com/oauth-xx/oauth2) for OAuth 2.0 implementations in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "oauth"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install oauth

## Compatibility

Targeted ruby compatibility is non-EOL versions of Ruby, currently 2.6, 2.7, and
3.0. Ruby is limited to 2.0+ in the gemspec, and this may change while the gem is
still at version 0.x.  The `master` branch currently targets 0.6.x releases.

| Ruby OAuth Version   | Officially Supported Rubies                 | Unofficially Supported Rubies |
|--------------------- | ------------------------------------------- | ----------------------------- |
| 0.7.x (hypothetical) | 2.7, 3.0, 3.1                               | 2.6                           |
| 0.6.x                | 2.6, 2.7, 3.0                               | 2.3, 2.4, 2.5                 |
| 0.5.x                | 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 3.0 |                               |

NOTE: 0.5.7 is anticipated as last release of the 0.5.x series.

## Basics

This is a ruby library which is intended to be used in creating Ruby Consumer
and Service Provider applications. It is NOT a Rails plugin, but could easily
be used for the foundation for such a Rails plugin.

As a matter of fact it has been pulled out from an OAuth Rails GEM
(https://rubygems.org/gems/oauth-plugin https://github.com/pelle/oauth-plugin)
which now uses this gem as a dependency.

## Usage

We need to specify the oauth_callback url explicitly, otherwise it defaults to
"oob" (Out of Band)

```ruby
callback_url = "http://127.0.0.1:3000/oauth/callback"
```

Create a new `OAuth::Consumer` instance by passing it a configuration hash:

```ruby
oauth_consumer = OAuth::Consumer.new("key", "secret", site: "https://agree2")
```

Start the process by requesting a token

```ruby
request_token = oauth_consumer.get_request_token(oauth_callback: callback_url)

session[:token] = request_token.token
session[:token_secret] = request_token.secret
redirect_to request_token.authorize_url(oauth_callback: callback_url)
```

When user returns create an access_token

```ruby
hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret] }
request_token = OAuth::RequestToken.from_hash(oauth_consumer, hash)
access_token = request_token.get_access_token
# For 3-legged authorization, flow oauth_verifier is passed as param in callback
# access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])
@photos = access_token.get("/photos.xml")
```

Now that you have an access token, you can use Typhoeus to interact with the
OAuth provider if you choose.

```ruby
require "typhoeus"
require "oauth/request_proxy/typhoeus_request"
oauth_params = { consumer: oauth_consumer, token: access_token }
hydra = Typhoeus::Hydra.new
req = Typhoeus::Request.new(uri, options) # :method needs to be specified in options
oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(request_uri: uri))
req.options[:headers]["Authorization"] = oauth_helper.header # Signs the request
hydra.queue(req)
hydra.run
@response = req.response
```

## More Information

* RubyDoc Documentation: [![RubyDoc.info](https://img.shields.io/badge/documentation-rubydoc-brightgreen.svg?style=flat)][documentation]
* Mailing List/Google Group: [![Mailing List](https://img.shields.io/badge/group-mailinglist-violet.svg?style=social&logo=google)][mailinglist]
* GitHub Discussions: [![Discussion](https://img.shields.io/badge/discussions-github-brightgreen.svg?style=flat)][gh_discussions]
* Live Chat on Gitter: [![Join the chat at https://gitter.im/oauth-xx/oauth-ruby](https://badges.gitter.im/Join%20Chat.svg)][chat]
* Maintainer's Blog: [![Blog](https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat)][blogpage]

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/oauth-xx/oauth-ruby][source]. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct][conduct].

To submit a patch, please fork the oauth project and create a patch with
tests. Once you're happy with it send a pull request and post a message to the
[google group][mailinglist].

## Contributors

[![Contributors](https://contrib.rocks/image?repo=oauth-xx/oauth-ruby)]("https://github.com/oauth-xx/oauth-ruby/graphs/contributors")

Made with [contributors-img](https://contrib.rocks).

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, a new version should be
immediately released that restores compatibility. Breaking changes to the public API will only be introduced with new
major versions.

As a result of this policy, you can (and should) specify a dependency on this gem using
the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency "oauth", "~> 0.5"
```

## License

The gem is available as open source under the terms of
the [MIT License][license] [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][license-ref].
See [LICENSE][license] for the [Copyright Notice][copyright-notice-explainer].

## Contact

OAuth Ruby has been created and maintained by a large number of talented
individuals. The current maintainer is Peter Boling ([@pboling][gh_sponsors]).

Comments are welcome. Contact the [OAuth Ruby mailing list (Google Group)][mailinglist] or [GitHub Discussions][gh_discussions].

[copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year

[gh_discussions]: https://github.com/oauth-xx/oauth-ruby/discussions

[mailinglist]: http://groups.google.com/group/oauth-ruby

[conduct]: https://github.com/oauth-xx/oauth-ruby/blob/master/CODE_OF_CONDUCT.md

[license]: LICENSE

[license-ref]: https://opensource.org/licenses/MIT

[semver]: http://semver.org/

[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint

[railsbling]: http://www.railsbling.com

[peterboling]: http://www.peterboling.com

[aboutme]: https://about.me/peter.boling

[angelme]: https://angel.co/peter-boling

[coderme]:http://coderwall.com/pboling

[followme-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow

[tweetme]: http://twitter.com/galtzo

[politicme]: https://nationalprogressiveparty.org

[documentation]: https://rubydoc.info/github/oauth-xx/oauth-ruby/main

[source]: https://github.com/oauth-xx/oauth-ruby/

[actions]: https://github.com/oauth-xx/oauth-ruby/actions

[issues]: https://github.com/oauth-xx/oauth-ruby/issues

[climate_maintainability]: https://codeclimate.com/github/oauth-xx/oauth-ruby/maintainability

[climate_coverage]: https://codeclimate.com/github/oauth-xx/oauth-ruby/test_coverage

[codecov_coverage]: https://codecov.io/gh/oauth-xx/oauth-ruby

[code_triage]: https://www.codetriage.com/oauth-xx/oauth-ruby

[depfu]: https://depfu.com/github/oauth-xx/oauth-ruby?project_id=22868

[blogpage]: http://www.railsbling.com/tags/oauth/

[rubygems]: https://rubygems.org/gems/oauth

[chat]: https://gitter.im/oauth-xx/oauth-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

[maintenancee_policy]: https://guides.rubyonrails.org/maintenance_policy.html#security-issues

[liberapay_donate]: https://liberapay.com/pboling/donate

[gh_sponsors]: https://github.com/sponsors/pboling