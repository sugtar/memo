# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( memo_item_index.js )
Rails.application.config.assets.precompile += %w( memo_item_show.js )
Rails.application.config.assets.precompile += %w( show_web_app_part.js )
Rails.application.config.assets.precompile += %w( show_web_app_part.css )
Rails.application.config.assets.precompile += %w( memo_items.css )
Rails.application.config.assets.precompile += %w( scaffold.css.sappcss )
