require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Authentication strategy for connecting with Mail.ru OAuth 2.0
    class MailRu < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'userinfo'

      option :name, 'mail_ru'

      option :client_options, {
        site: 'https://oauth.mail.ru',
        token_url: '/token',
        authorize_url: '/login'
      }

      option :auth_token_params, { mode: :query }

      uid { raw_info['email'] }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email'],
          locale: raw_info['locale'],
          gender: raw_info['gender'],
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          image: raw_info['image']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://oauth.mail.ru/userinfo').parsed
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      private

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
