## Contributing

Bug reports and pull requests are welcome on GitHub at [https://gitlab.com/oauth-xx/oauth][source]. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct][conduct].

To submit a patch, please fork the project and create a patch with
tests. Once you're happy with it send a pull request and post a message to the
[google group][mailinglist].

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

[![Contributors](https://contrib.rocks/image?repo=oauth-xx/oauth-ruby)][contributors]

Made with [contributors-img][contrib-rocks].

[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)

[conduct]: https://gitlab.com/oauth-xx/oauth/-/blob/main/CODE_OF_CONDUCT.md
[contributors]: https://gitlab.com/oauth-xx/oauth/-/graphs/main
[mailinglist]: http://groups.google.com/group/oauth-ruby
[source]: https://gitlab.com/oauth-xx/oauth/
[contrib-rocks]: https://contrib.rocks