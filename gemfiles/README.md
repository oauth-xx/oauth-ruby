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
gem "actionpack", [">= 6", "< 8"]
```

# *.gemfile Naming

In the naming of gemfiles, we will use the below shorthand for actionpack and version

| Gem        | Version | Gemfile    |
|------------|---------|------------|
| actionpack | ~> 6.0  | a6.gemfile |
| actionpack | ~> 7.0  | a7.gemfile |

# References

Compatibility Matrix for Ruby and Rails:
* https://www.fastruby.io/blog/ruby/rails/versions/compatibility-table.html
