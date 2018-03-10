Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("node_modules")

Rails.application.config.assets.precompile += %w( static_pages.scss
  user_footer.scss login.scss validate.scss managers/manager.scss notification.scss)

Rails.application.config.assets.precompile += %w( static_pages.js
  login_custom.js upload_picture.js validates/change_pass.js managers/manager.js
  show_hide.js edit_mark.js remarking.js )

Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/images/gal_del.png )
