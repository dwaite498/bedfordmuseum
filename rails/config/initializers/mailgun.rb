Rails.application.config.action_mailer.delivery_method = :mailgun
Rails.application.config.action_mailer.mailgun_settings = {
  api_key: Rails.application.secrets.mailgun_key,
  domain: Rails.application.secrets.mailgun_domain
}
