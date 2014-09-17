# OmniAuth Mail.ru

This is unofficial [OmniAuth](https://github.com/intridea/omniauth) strategy for Mail.ru.

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

Replace `"API_KEY"` and `"PRIVATE_KEY"` with the appropriate values you obtained (https://api.mail.ru).

## Authentication Hash
An example auth hash available in `request.env['omniauth.auth']`:

```ruby
{
      provider: 'mail_ru',
      uid: '1111111111',
      info: {
          name: 'John Smith',
          email: 'john@mail.ru',
          nickname: 'JohnS',
          first_name: 'John',
          last_name: 'Smith',
          image: 'http://avt.appsmail.ru/mail/john/_avatar50',
          urls: {
              'Mailru' => 'http://my.mail.ru/mail/john/'
          }
      },
      credentials: {
          token: '4ec9286c2f...',
          refresh_token: '351456424ad7c5...',
          expires_at: 1411054463,
          expires: true
      },
      extra: {
          raw_info: {
              pic_50: 'http://avt.appsmail.ru/mail/john/_avatar50',
              friends_count: 256,
              show_age: 1,
              has_photosafe: 0,
              nick: 'JohnS',
              is_friend: 0,
              is_online: 1,
              has_pic: 1,
              email: 'john@mail.ru',
              pic_190: 'http://avt.appsmail.ru/mail/john/_avatar190',
              referer_id: '',
              pic_32: 'http://avt.appsmail.ru/mail/john/_avatar32',
              referer_type: '',
              last_visit: '1410961776',
              uid: '1111111111',
              app_installed: 1,
              status_text: '',
              pic_22: 'http://avt.appsmail.ru/mail/john/_avatar22',
              age: 25,
              last_name: 'Smith',
              is_verified: 0,
              pic_big: 'http://avt.appsmail.ru/mail/john/_avatarbig',
              vip: 0,
              birthday: '01.01.1901',
              link: 'http://my.mail.ru/mail/john/',
              pic_128: 'http://avt.appsmail.ru/mail/john/_avatar128',
              sex: 0,
              pic: 'http://avt.appsmail.ru/mail/john/_avatar',
              pic_small: 'http://avt.appsmail.ru/mail/john/_avatarsmall',
              pic_180: 'http://avt.appsmail.ru/mail/john/_avatar180',
              first_name: 'John',
              pic_40: 'http://avt.appsmail.ru/mail/john/_avatar40?1229336384'
          }
      }
  }

```

## License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
