<p align="center">
    <a href="http://oauth.net/core/1.0/" target="_blank" rel="noopener">
      <img width="124px" src="https://github.com/oauth-xx/oauth-ruby/raw/main/docs/images/logo/Oauth_logo.svg?raw=true" alt="OAuth 1.0 Logo by Chris Messina, CC BY-SA 3.0, via Wikimedia Commons">
    </a>
    <a href="https://www.ruby-lang.org/" target="_blank" rel="noopener">
      <img width="124px" src="https://github.com/oauth-xx/oauth-ruby/raw/main/docs/images/logo/ruby-logo-198px.svg?raw=true" alt="Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5">
    </a>
</p>

# Ruby OAuth

[![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

---

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-yellow.svg
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/a_more_different_coffee-✓-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-yellow.svg?style=flat


OAuth 1.0 is an industry-standard protocol for authorization.

This is a RubyGem for implementing both OAuth 1.0 clients and servers in Ruby applications.
See the sibling `oauth2` gem for OAuth 2.0 implementations in Ruby.

* [OAuth 1.0 Spec][oauth1-spec]
* [oauth2 sibling gem][sibling-gem] for OAuth 2.0 implementations in Ruby.

[oauth1-spec]: http://oauth.net/core/1.0/
[sibling-gem]: https://gitlab.com/oauth-xx/oauth2

**New EOL Policy**

Versions 1.1.x will be EOL no later than April, 2023.
Versions 1.0.x will be EOL no later than April, 2023.
Versions 0.6.x will be EOL no later than April, 2023.
Versions 0.5.x will be EOL no later than April, 2023.

This will facilitate dropping support for old, dead, and crusty versions of Ruby.

Non-commercial support for the oldest version of Ruby (which itself is going EOL) will be dropped each year in April.

Please upgrade to version 1.1.x.  The only breaking change in 1.0.x is dropping old Rubies,
while 1.1.x extracts the CLI tool to an external gem dependency ([`oauth-tty`](https://gitlab.com/oauth-xx/oauth-tty)).

## Status

<!--
Numbering rows and badges in each row as a visual "database" lookup,
    as the table is extremely dense, and it can be very difficult to find anything
Putting one on each row here, to document the emoji that should be used, and for ease of copy/paste.

row #s:
1️⃣
2️⃣
3️⃣
4️⃣
5️⃣
6️⃣
7️⃣

badge #s:
⛳️
🖇
🏘
🚎
🖐
🧮
📗

appended indicators:
♻️ - URL needs to be updated from SASS integration. Find / Replace is insufficient.
-->

|     | Project               | bundle add oauth                                                                                                                                                                                                                                                   |
|:----|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1️⃣ | name, license, docs   | [![RubyGems.org][⛳️name-img]][⛳️gem] [![License: MIT][🖇src-license-img]][🖇src-license] [![RubyDoc.info][🚎yard-img]][🚎yard] [![SemVer 2.0.0][🧮semver-img]][🧮semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]                       |
| 2️⃣ | version & activity    | [![Gem Version][⛳️version-img]][⛳️gem] [![Total Downloads][🖇DL-total-img]][⛳️gem] [![Download Rank][🏘DL-rank-img]][⛳️gem] [![Source Code][🚎src-main-img]][🚎src-main] [![Contributors][🖐contributors-img]][🖐contributors]                                     |
| 3️⃣ | maintenance & linting | [![Maintainability][⛳cclim-maint-img♻️]][⛳cclim-maint] [![Helpers][🖇triage-help-img]][🖇triage-help] [![Depfu][🏘depfu-img♻️]][🏘depfu♻️] [![Style][🖐style-wf-img]][🖐style-wf]                                                                                  |
| 4️⃣ | testing               | [![Supported][🏘sup-wf-img]][🏘sup-wf] [![Heads][🚎heads-wf-img]][🚎heads-wf] [![MacOS][🧮mac-wf-img]][🧮mac-wf] [![Windows][📗win-wf-img]][📗win-wf]                                                                                                              |
| 5️⃣ | coverage & security   | [![CodeClimate][⛳cclim-cov-img♻️]][⛳cclim-cov] [![CodeCov][🖇codecov-img♻️]][🖇codecov] [![Coveralls][🏘coveralls-img]][🏘coveralls] [![Security Policy][🚎sec-pol-img]][🚎sec-pol] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Code Coverage][🧮cov-wf-img]][🧮cov-wf] |
| 6️⃣ | resources             | [![Mailing List][⛳mail-list-img]][⛳mail-list] [![Get help on Codementor][🖇codementor-img]][🖇codementor] [![Chat][🏘chat-img]][🏘chat] [![Blog][🚎blog-img]][🚎blog] [![Blog][🖐wiki-img]][🖐wiki]                                                                |
| 7️⃣ | spread 💖             | [![Liberapay Patrons][⛳liberapay-img]][⛳liberapay] [![Sponsor Me][🖇sponsor-img]][🖇sponsor] [![Code of Conduct][🚎code-conduct-img]][🚎code-conduct] [![Tweet @ Peter][🏘tweet-img]][🏘tweet] [🌏][aboutme] [👼][angelme] [💻][coderme]                           |

<!--
The link tokens in the following sections should be kept ordered by the row and badge numbering scheme
-->

<!-- 1️⃣ name, license, docs -->
[⛳️gem]: https://rubygems.org/gems/oauth
[⛳️name-img]: https://img.shields.io/badge/name-oauth-brightgreen.svg?style=flat
[🖇src-license]: https://opensource.org/licenses/MIT
[🖇src-license-img]: https://img.shields.io/badge/License-MIT-green.svg
[🚎yard]: https://www.rubydoc.info/gems/oauth
[🚎yard-img]: https://img.shields.io/badge/documentation-rubydoc-brightgreen.svg?style=flat
[🧮semver]: http://semver.org/
[🧮semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

<!-- 2️⃣ version & activity -->
[⛳️version-img]: http://img.shields.io/gem/v/oauth.svg
[🖇DL-total-img]: https://img.shields.io/gem/dt/oauth.svg
[🏘DL-rank-img]: https://img.shields.io/gem/rt/oauth.svg
[🚎src-main]: https://gitlab.com/oauth-xx/oauth/-/tree/main
[🚎src-main-img]: https://img.shields.io/badge/source-gitlab-blue.svg?style=flat
[🖐contributors]: https://gitlab.com/oauth-xx/oauth/-/graphs/main
[🖐contributors-img]: https://img.shields.io/github/contributors-anon/oauth-xx/oauth-ruby

<!-- 3️⃣ maintenance & linting -->
[⛳cclim-maint]: https://codeclimate.com/github/oauth-xx/oauth-ruby/maintainability
[⛳cclim-maint-img♻️]: https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/maintainability
[🖇triage-help]: https://www.codetriage.com/oauth-xx/oauth-ruby
[🖇triage-help-img]: https://www.codetriage.com/oauth-xx/oauth-ruby/badges/users.svg
[🏘depfu♻️]: https://depfu.com/github/oauth-xx/oauth-ruby?project_id=22868
[🏘depfu-img♻️]: https://badges.depfu.com/badges/d570491bac0ad3b0b65deb3c82028327/count.svg
[🖐style-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/style.yml
[🖐style-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/style.yml/badge.svg

<!-- 4️⃣ testing -->
[🏘sup-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/supported.yml
[🏘sup-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/supported.yml/badge.svg
[🚎heads-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/heads.yml
[🚎heads-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/heads.yml/badge.svg
[🧮mac-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/macos.yml
[🧮mac-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/macos.yml/badge.svg
[📗win-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/windows.yml
[📗win-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/windows.yml/badge.svg

<!-- 5️⃣ coverage & security -->
[⛳cclim-cov]: https://codeclimate.com/github/oauth-xx/oauth-ruby/test_coverage
[⛳cclim-cov-img♻️]: https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/test_coverage
[🖇codecov-img♻️]: https://codecov.io/gh/oauth-xx/oauth-ruby/branch/main/graph/badge.svg?token=4ZNAWNxrf9
[🖇codecov]: https://codecov.io/gh/oauth-xx/oauth-ruby
[🏘coveralls]: https://coveralls.io/github/oauth-xx/oauth-ruby?branch=main
[🏘coveralls-img]: https://coveralls.io/repos/github/oauth-xx/oauth-ruby/badge.svg?branch=main
[🚎sec-pol]: https://gitlab.com/oauth-xx/oauth/-/blob/main/SECURITY.md
[🚎sec-pol-img]: https://img.shields.io/badge/security-policy-brightgreen.svg?style=flat
[🖐codeQL]: https://github.com/oauth-xx/oauth-ruby/security/code-scanning
[🖐codeQL-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/codeql-analysis.yml/badge.svg
[🧮cov-wf]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/coverage.yml
[🧮cov-wf-img]: https://github.com/oauth-xx/oauth-ruby/actions/workflows/coverage.yml/badge.svg

<!-- 6️⃣ resources -->
[⛳mail-list]: http://groups.google.com/group/oauth-ruby
[⛳mail-list-img]: https://img.shields.io/badge/group-mailinglist-violet.svg?style=social&logo=google
[🖇codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[🖇codementor-img]: https://cdn.codementor.io/badges/get_help_github.svg
[🏘chat]: https://gitter.im/oauth-xx/oauth-ruby
[🏘chat-img]: https://img.shields.io/gitter/room/oauth-xx/oauth-ruby.svg
[🚎blog]: http://www.railsbling.com/tags/oauth-ruby/
[🚎blog-img]: https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat
[🖐wiki]: https://gitlab.com/oauth-xx/oauth/-/wikis/home
[🖐wiki-img]: https://img.shields.io/badge/wiki-examples-brightgreen.svg?style=flat

<!-- 7️⃣ spread 💖 -->
[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/sponsor-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🏘tweet-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow
[🏘tweet]: http://twitter.com/galtzo
[🚎code-conduct]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CODE_OF_CONDUCT.md
[🚎code-conduct-img]: https://img.shields.io/badge/code-conduct-black.svg?style=flat

<!-- Maintainer Links -->
[aboutme]: https://about.me/peter.boling
[angelme]: https://angel.co/peter-boling
[coderme]:http://coderwall.com/pboling
[followme-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow
[gh_sponsors]: https://github.com/sponsors/pboling
[liberapay_donate]: https://liberapay.com/pboling/donate
[peterboling]: http://www.peterboling.com
[railsbling]: http://www.railsbling.com

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add oauth

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install oauth

## OAuth for Enterprise

Available as part of the Tidelift Subscription.

The maintainers of OAuth2 and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use. [Learn more.](https://tidelift.com/subscription/pkg/rubygems-oauth?utm_source=rubygems-oauth&utm_medium=referral&utm_campaign=enterprise)

## Security contact information [![Security Policy][🚎sec-pol-img]][🚎sec-pol]

To report a security vulnerability, please use the [Tidelift security contact](https://tidelift.com/security).
Tidelift will coordinate the fix and disclosure.

For more see [SECURITY.md][🚎sec-pol].

## Compatibility

Targeted ruby compatibility is non-EOL versions of Ruby, currently 2.7, 3.0, and
3.1. Ruby is limited to 2.7+ in the gemspec, and this will change with major version bumps,
in accordance with the SemVer spec.

The `main` branch now targets 1.1.x releases, for Ruby >= 2.7.
See `v1.0-maintenance` (EOL April, 2023) branch for Ruby >= 2.7.
See `v0.6-maintenance` (EOL April, 2023) branch for Ruby >= 2.4.
See `v0.5-maintenance` (EOL April, 2023) branch for Ruby >= 2.0.

NOTE: No further releases of versions < 1.0.x are anticipated.

<details>
  <summary>Ruby Engine Compatibility Policy</summary>

This gem is tested against MRI, and to a lesser extent, against JRuby, and Truffleruby.
Each of those has varying versions that target a specific version of MRI Ruby.
This gem should work in the just-listed Ruby engines according to the targeted MRI compatibility in the table below.
If you would like to add support for additional engines,
first make sure Github Actions supports the engine,
then submit a PR to the correct maintenance branch as according to the table below.
</details>

<details>
  <summary>Ruby Version Compatibility Policy</summary>

If something doesn't work on one of these interpreters, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be responsible for providing patches in a timely
fashion. If critical issues for a particular implementation exist at the time
of a major release, support for that Ruby version may be dropped.
</details>

|     | Ruby OAuth Version | Maintenance Branch | EOL     | 🚂 Compatibility       | Official 💎   | Unofficial 💎                | Incidental 💎 |
|:----|--------------------|--------------------|---------|------------------------|---------------|------------------------------|---------------|
| 1️⃣ | 1.1.x              | `main`             | 04/2023 | Rails 6, 7             | 2.7, 3.0, 3.1 | none                         | none          |
| 2️⃣ | 1.0.x              | `v1.0-maintenance` | 04/2023 | Rails 6, 7             | 2.7, 3.0, 3.1 | none                         | none          |
| 3️⃣ | 0.6.x              | `v0.6-maintenance` | 04/2023 | Rails 5, 6, 7          | 2.7, 3.0, 3.1 | 2.5, 2.6                     | 2.4           |
| 4️⃣ | 0.5.x              | `v0.5-maintenance` | 04/2023 | Rails 2, 3, 4, 5, 6, 7 | 2.7, 3.0, 3.1 | 2.1, 2.2, 2.3, 2.4, 2.5, 2.6 | 2.0           |
| 5️⃣ | older              | ⛔                  | ⛔       | ⛔                      | ⛔             | ⛔                            | ⛔             |

See [SECURITY.md][🚎sec-pol]

🚂 NOTE: See notes on Rails in next section.

## Basics

This is a ruby library which is intended to be used in creating Ruby Consumer
and Service Provider applications. It is NOT a Rails plugin, but could easily
be used for the foundation for such a Rails plugin.

This gem was originally extracted from @pelle's [oauth-plugin](https://github.com/pelle/oauth-plugin)
gem. After extraction that gem was made to depend on this gem.

Unfortunately, this gem does have some Rails related bits that are
**optional** to load. You don't need Rails! The Rails bits may be pulled out
into a separate gem with the 1.x minor updates of this gem.

## Extensions

* [oauth-tty (on Gitlab)](https://gitlab.com/oauth-xx/oauth-tty) ([rubygems.org](https://rubygems.org/gems/oauth-tty))

## Usage

We need to specify the `oauth_callback` url explicitly, otherwise it defaults to
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

* RubyDoc Documentation: [![RubyDoc.info][🚎yard-img]][🚎yard]
* Mailing List/Google Group: [![Mailing List][⛳mail-list-img]][⛳mail-list]
* Live Chat on Gitter: [![Join the chat at https://gitter.im/oauth-xx/oauth-ruby][🏘chat-img]][🏘chat]
* Maintainer's Blog: [![Blog][🚎blog-img]][🚎blog]

## Code of Conduct

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct][🚎code-conduct].

## Contributing

Bug reports and pull requests are welcome on GitLab at [https://gitlab.com/oauth-xx/oauth/-/issues][issues].

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct][🚎code-conduct].

See [CONTRIBUTING.md][contributing] for detailed instructions on how to help!

## Contributors

See [https://gitlab.com/oauth-xx/oauth/-/graphs/main][🚎contributors]

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][🧮semver]. Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, a new version should be
immediately released that restores compatibility. Breaking changes to the public API will only be introduced with new
major versions.  Compatibility with a major and minor versions of Ruby will only be changed with a major version bump.

As a result of this policy, you can (and should) specify a dependency on this gem using
the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency "oauth", "~> 1.1"
```

## License

The gem is available as open source under the terms of
the [MIT License][license] [![License: MIT][🖇src-license-img]][🖇src-license].
See [LICENSE.txt][license] for the [Copyright Notice][copyright-notice-explainer].

## Contact

OAuth Ruby has been created and maintained by a large number of talented
individuals. The current maintainer is Peter Boling (@pboling).  Please
[support with donations at Liberapay][liberapay_donate]).

Comments are welcome. Contact the [OAuth Ruby mailing list (Google Group)][⛳mail-list] or [join the live chat at https://gitter.im/oauth-xx/oauth-ruby][🏘chat].

[contributing]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CONTRIBUTING.md
[copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[actions]: https://github.com/oauth-xx/oauth-ruby/actions
[issues]: https://gitlab.com/oauth-xx/oauth/-/issues
[license]: https://gitlab.com/oauth-xx/oauth/-/blob/main/LICENSE.txt
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
