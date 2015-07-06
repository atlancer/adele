# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# http://stackoverflow.com/questions/19103759/rails-4-custom-error-pages-for-404-500-and-where-is-the-default-500-error-mess
Rails.application.config.assets.precompile += %w(404.html 500.html)
Rails.application.config.assets.paths << Rails.root.join('app/assets/error_pages')
Rails.application.config.assets.register_mime_type('text/html', '.html')
# for Slim
Rails.application.assets.register_engine('.slim', Slim::Template)
# for Haml
# Rails.application.assets.register_engine('.haml', Tilt::HamlTemplate)
