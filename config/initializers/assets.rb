Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("node_modules")

Rails.application.config.assets.precompile += %w( static_pages.scss
  user_footer.scss login.scss validate.scss)

Rails.application.config.assets.precompile += %w( static_pages.js
  login.js upload_picture.js validates/change_pass.js)
