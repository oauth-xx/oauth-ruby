## Contributing

Bug reports and pull requests are welcome on GitLab at [https://gitlab.com/oauth-xx/oauth][🚎src-main]. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct][🚎code-conduct].

Everyone interacting in the OAuth::TTY project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of conduct][🚎code-conduct].

To submit a patch, please fork the project and create a patch with
tests. Once you're happy with it send a pull request and post a message to the
[google group][mailinglist] or on the [gitter chat][🏘chat].

## Create a Patch

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Run tests

### Against Rails 6

```bash
BUNDLE_GEMFILE=gemfiles/a6.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/a6.gemfile bundle exec rake
```

### Against Rails 7

```bash
BUNDLE_GEMFILE=gemfiles/a7.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/a7.gemfile bundle exec rake
```

## Release

To release a new version:

1. update the version number in `version.rb`
2. run `bundle exec rake build:checksum`
3. move the built gem to project root
4. run `bin/checksum` to create the missing SHA256 checksum
5. move the built gem back to `pkg/`
6. run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

NOTE: You will need to have a public key in `certs/`, and list your cert in the
`gemspec`, in order to sign the new release.
See: [RubyGems Security Guide][rubygems-security-guide]

## Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)

[🚎code-conduct]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CODE_OF_CONDUCT.md
[🖐contributors]: https://gitlab.com/oauth-xx/oauth/-/graphs/main
[🖐contributors-img]: https://img.shields.io/github/contributors-anon/oauth-xx/oauth-ruby
[mailinglist]: http://groups.google.com/group/oauth-ruby
[🚎src-main]: https://gitlab.com/oauth-xx/oauth/-/tree/main
[🏘chat]: https://gitter.im/oauth-xx/oauth-ruby
[rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[rubygems]: https://rubygems.org
