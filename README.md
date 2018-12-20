# OmniAuth Mail.ru

This is unofficial [OmniAuth](https://github.com/intridea/omniauth) OAuth2 strategy for Mail.ru.

## Using

Add this gem to your Gemfile:

```ruby
gem 'omniauth-mail_ru'
```
# Configuration

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mail_ru, 'API_KEY', 'PRIVATE_KEY'
end
```

Replace `"API_KEY"` and `"PRIVATE_KEY"` with the appropriate values you obtained (https://oauth.mail.ru/app).

## Authentication Hash
An example auth hash available in `request.env['omniauth.auth']`:

```ruby
{
      provider: 'mail_ru',
      uid: 'alex@ivanov.ru',
      info: {
        gender: 'm',
        name: 'Алексей Иванов',
        locale: 'ru_RU',
        first_name: 'Алексей',
        last_name: 'Иванов',
        email: 'alex@ivanov.ru',
        image: 'https://....'
      },
      credentials: {
          token: '4ec9286c2f...',
          refresh_token: '351456424ad7c5...',
          expires_at: 1411054463,
          expires: true
      }
  }

```
