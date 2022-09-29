## Contributing

Bug reports and pull requests are welcome on GitLab at [https://gitlab.com/oauth-xx/oauth][🚎src-main]. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct][conduct].

To submit a patch, please fork the project and create a patch with
tests. Once you're happy with it send a pull request and post a message to the
[google group][mailinglist] or on the [gitter chat][🏘chat].

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

## Contributors

See: [https://gitlab.com/oauth-xx/oauth/-/graphs/main][🚎contributors]

[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)

[conduct]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CODE_OF_CONDUCT.md
[🚎contributors]: https://gitlab.com/oauth-xx/oauth/-/graphs/main
[mailinglist]: http://groups.google.com/group/oauth-ruby
[🚎src-main]: https://gitlab.com/oauth-xx/oauth/-/tree/main
[🏘chat]: https://gitter.im/oauth-xx/oauth-ruby