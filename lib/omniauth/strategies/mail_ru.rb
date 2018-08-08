require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Authentication strategy for connecting with Mail.ru OAuth 2.0
    class MailRu < OmniAuth::Strategies::OAuth2
      option :name, 'mail_ru'

      option :client_options,
             site: 'https://connect.mail.ru',
             token_url: '/oauth/token',
             authorize_url: '/oauth/authorize'

      uid { access_token.params['x_mailru_vid'] }

      info do
        {
          name: [raw_info['first_name'], raw_info['last_name']].join(' ').strip,
          email: raw_info['email'],
          nickname: raw_info['nick'],
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          image: raw_info['has_pic'].to_i == 1 ? (raw_info['pic_50'] || raw_info['pic_small']) : nil,
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
        @raw_info ||= access_token.get('https://www.appsmail.ru/platform/api', params: info_params).parsed.first
      end

      private

      def callback_url
        full_host + script_name + callback_path
      end

      def info_params
        params = {
          app_id: options.client_id,
          method: 'users.getInfo',
          secure: 1,
          session_key: access_token.token
        }
        params[:sig] = signature(params)

        params
      end

      def signature(params)
        params = params.sort.reduce([]) { |m, (key, value)| m.push("#{key}=#{value}") }.join
        Digest::MD5.hexdigest([params, options.client_secret].join)
      end
    end
  end
end
