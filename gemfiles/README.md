# History

This is a ruby library which is intended to be used in creating Ruby Consumer
and Service Provider applications. It is NOT a Rails plugin, but could easily
be used for the foundation for such a Rails plugin.

This gem was originally extracted from @pelle's [oauth-plugin](https://github.com/pelle/oauth-plugin)
gem. After extraction that gem was made to depend on this gem.

Unfortunately, this gem does have some Rails related bits that are
**optional** to load. You don't need Rails! The Rails bits may be pulled out
into a separate gem after the release of version 1.0 of this gem.

These `gemfiles` help with testing this gem against various versions of Rails-ish-ness.

```ruby
gem 'actionpack', ['>= 2', '< 8']
```

In the naming of gemfiles, we will use the below shorthand for actionpack and version

| Gem        | Version | Gemfile    |
|------------|---------|------------|
| actionpack | ~> 2.0  | a2.gemfile |
| actionpack | ~> 3.0  | a3.gemfile |
| actionpack | ~> 4.0  | a4.gemfile |
| actionpack | ~> 5.0  | a5.gemfile |
| actionpack | ~> 6.0  | a6.gemfile |
| actionpack | ~> 7.0  | a7.gemfile |
