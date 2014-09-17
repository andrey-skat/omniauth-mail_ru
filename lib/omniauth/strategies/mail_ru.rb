require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MailRu < OmniAuth::Strategies::OAuth2
      option :name, 'mail_ru'

      option :client_options, {
          site: 'https://connect.mail.ru/',
          token_url: '/oauth/token',
          authorize_url: '/oauth/authorize'
      }

      uid { access_token.params['x_mailru_vid'] }

      info do
        {
            name: [raw_info['first_name'], raw_info['last_name']].join(' ').strip,
            email: raw_info['email'],
            nickname: raw_info['nick'],
            first_name: raw_info['first_name'],
            last_name: raw_info['last_name'],
            image: (raw_info['has_pic'].to_i == 1) && raw_info['pic_50'] || raw_info['pic_small'],
            urls: {
                'Mailru' => raw_info['link']
            }
        }
      end

      extra do
        {
            raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('http://www.appsmail.ru/platform/api', params: params).parsed.first
      end

      def params
        params = {
            app_id: options.client_id,
            method: 'users.getInfo',
            session_key: access_token.token
        }
        params[:sig] = signature(params)

        params
      end

      def signature(params)
        params = params.sort.reduce('') { |m, (key, value)| m << "#{key}=#{value}"; m }
        Digest::MD5.hexdigest([uid, params, options.client_secret].join)
      end
    end
  end
end