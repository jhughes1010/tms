ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "atmel.com",
  :user_name            => "jhughes.atmel",
  :password             => "keyboard2012",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "10.95.114.17:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
