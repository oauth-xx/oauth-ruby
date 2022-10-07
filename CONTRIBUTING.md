#<--rubocop/md-->## Contributing
#<--rubocop/md-->
#<--rubocop/md-->Bug reports and pull requests are welcome on GitLab at [https://gitlab.com/oauth-xx/oauth][🚎src-main]. This project is
#<--rubocop/md-->intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
#<--rubocop/md-->the [code of conduct][🚎code-conduct].
#<--rubocop/md-->
#<--rubocop/md-->Everyone interacting in the OAuth::TTY project's codebases, issue trackers, chat
#<--rubocop/md-->rooms and mailing lists is expected to follow the [code of conduct][🚎code-conduct].
#<--rubocop/md-->
#<--rubocop/md-->To submit a patch, please fork the project and create a patch with
#<--rubocop/md-->tests. Once you're happy with it send a pull request and post a message to the
#<--rubocop/md-->[google group][mailinglist] or on the [gitter chat][🏘chat].
#<--rubocop/md-->
#<--rubocop/md-->## Create a Patch
#<--rubocop/md-->
#<--rubocop/md-->After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
#<--rubocop/md-->
#<--rubocop/md-->To install this gem onto your local machine, run `bundle exec rake install`.
#<--rubocop/md-->
#<--rubocop/md-->## Run tests
#<--rubocop/md-->
#<--rubocop/md-->### Against Rails 6
#<--rubocop/md-->
#<--rubocop/md-->```bash
#<--rubocop/md-->BUNDLE_GEMFILE=gemfiles/a6.gemfile bundle install
#<--rubocop/md-->BUNDLE_GEMFILE=gemfiles/a6.gemfile bundle exec rake
#<--rubocop/md-->```
#<--rubocop/md-->
#<--rubocop/md-->### Against Rails 7
#<--rubocop/md-->
#<--rubocop/md-->```bash
#<--rubocop/md-->BUNDLE_GEMFILE=gemfiles/a7.gemfile bundle install
#<--rubocop/md-->BUNDLE_GEMFILE=gemfiles/a7.gemfile bundle exec rake
#<--rubocop/md-->```
#<--rubocop/md-->
#<--rubocop/md-->## Release
#<--rubocop/md-->
#<--rubocop/md-->To release a new version:
#<--rubocop/md-->
#<--rubocop/md-->1. update the version number in `version.rb`
#<--rubocop/md-->2. run `bundle exec rake build:checksum`
#<--rubocop/md-->3. move the built gem to project root
#<--rubocop/md-->4. run `bin/checksum` to create the missing SHA256 checksum
#<--rubocop/md-->5. move the built gem back to `pkg/`
#<--rubocop/md-->6. run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
#<--rubocop/md-->
#<--rubocop/md-->NOTE: You will need to have a public key in `certs/`, and list your cert in the
#<--rubocop/md-->`gemspec`, in order to sign the new release.
#<--rubocop/md-->See: [RubyGems Security Guide][rubygems-security-guide]
#<--rubocop/md-->
#<--rubocop/md-->## Contributors
#<--rubocop/md-->
#<--rubocop/md-->[![Contributors][🖐contributors-img]][🖐contributors]
#<--rubocop/md-->
#<--rubocop/md-->[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)
#<--rubocop/md-->
#<--rubocop/md-->[🚎code-conduct]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CODE_OF_CONDUCT.md
#<--rubocop/md-->[🖐contributors]: https://gitlab.com/oauth-xx/oauth/-/graphs/main
#<--rubocop/md-->[🖐contributors-img]: https://img.shields.io/github/contributors-anon/oauth-xx/oauth-ruby
#<--rubocop/md-->[mailinglist]: http://groups.google.com/group/oauth-ruby
#<--rubocop/md-->[🚎src-main]: https://gitlab.com/oauth-xx/oauth/-/tree/main
#<--rubocop/md-->[🏘chat]: https://gitter.im/oauth-xx/oauth-ruby
#<--rubocop/md-->[rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
#<--rubocop/md-->[rubygems]: https://rubygems.org
