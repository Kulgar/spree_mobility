# Spree Mobility

This is a Spree model translation gem based on `spree_globalize` for [Spree Commerce][1] version 4.3+.
It uses `mobility` instead of `globalize`, since `globalize` is not actively developed anymore.
It is a drop-in replacement for `spree_globalize` and will use your existing translations.

Currently, this gem is tested with Spree 4.3.1.

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'spree_i18n', '~> 5.0'
gem 'friendly_id-mobility', github: 'mrbrdo/friendly_id-mobility', branch: 'master'
gem 'spree_mobility'
```

Run `bundle install`

You can use the generator to install migrations and append spree_mobility assets to
your app spree manifest file.

    rails g spree_mobility:install

It is also recommended to configure Mobility fallback locales, especially if your admin locale is not the same as your Store's default_locale. For example if you have en and de locale:

```ruby
# config/initializers/mobility.rb
Mobility.configure do
  plugins do
    fallbacks({ :en => [:de], :de => [:en] })
  end
end
```

---

## Improvements over spree_globalize

This gem offers several improvements over `spree_globalize`:

* Proper translation fallbacks support (if a translation for the current locale is missing, it will fallback to other locales, strictly based on configured fallbacks):
  * for finders (slug/permalink)
  * when searching by product name (frontend & admin search)
* Proper validations on translation models (e.g. slug presence validation), also meaning uniqueness validations will now work correctly per-locale
* Better support for future versions of Rails as `mobility` is more actively maintained

Admin:

* Rich-text editor for product description translations in admin (if enabled)
* Searching by product SKU in admin
* Admin product search will no longer return duplicate results
* Works correctly if using custom Spree.admin_path config


## Model Translations

This feature uses the [Mobility][3] gem to localize model data.
So far the following models are translatable:

    Product, Promotion, OptionType, Taxonomy, Taxon, Property, Store and ShippingMethod.

Start your server and you should see a TRANSLATIONS link or a flag icon on each
admin section that supports this feature.

*Every record needs to have a translation. If by any chance you remove `spree_mobility`
from your Gemfile, add some records and then add `spree_mobility` gem back you might get
errors like ``undefined method for nilClass`` because Mobility will try fetch
translations that do not exist.*

---

## Contributing

[See corresponding guidelines][7]

---

Copyright (c) 2010-2022 MrBrdo. released under the [New BSD License][6]

[1]: http://spreecommerce.org
[2]: http://guides.spreecommerce.org/developer/i18n.html
[3]: https://github.com/shioyama/mobility
[5]: https://github.com/spree-contrib/spree_globalize/graphs/contributors
[6]: https://github.com/mrbrdo/spree_mobility/blob/master/LICENSE.md
[7]: https://github.com/mrbrdo/spree_mobility/blob/master/CONTRIBUTING.md
[8]: https://github.com/spree-contrib/spree_i18n
