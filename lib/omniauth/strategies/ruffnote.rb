require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ruffnote < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://ruffnote.com',
        authorize_url: '/oauth/authorize'
        #:token_url => 'https://github.com/login/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          email: raw_info['email'],
          name: raw_info['username'],
          nickname: raw_info['username'],
          description: raw_info['description'],
          image: "https://ruffnote.com/#{raw_info['username']}/avatar",
          urls: {
            Website: raw_info['url'],
          }
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

      def email
         (email_access_allowed?) ? primary_email : raw_info['email']
      end

      def primary_email
        primary = emails.find{|i| i['primary'] }
        primary && primary['email'] || emails.first && emails.first['email']
      end

      # The new /user/emails API - http://developer.github.com/v3/users/emails/#future-response
      def emails
        return [] unless email_access_allowed?
        access_token.options[:mode] = :query
        @emails ||= access_token.get('user/emails', :headers => { 'Accept' => 'application/vnd.github.v3' }).parsed
      end

      def email_access_allowed?
        options['scope'] =~ /user/
      end

    end
  end
end

OmniAuth.config.add_camelization 'ruffnote', 'Ruffnote'
