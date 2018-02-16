# frozen_string_literal: true

require 'spec_helper'
require 'omniauth-mail_ru'

describe OmniAuth::Strategies::MailRu do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [200, {}, ['Hello.']]
    end
  end

  subject do
    OmniAuth::Strategies::MailRu.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://connect.mail.ru')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('/oauth/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('/oauth/token')
    end

    describe 'overrides' do
      context 'as strings' do
        it 'should allow overriding the site' do
          @options = { client_options: { 'site' => 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { 'authorize_url' => 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { 'token_url' => 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end

      context 'as symbols' do
        it 'should allow overriding the site' do
          @options = { client_options: { site: 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { authorize_url: 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { token_url: 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end
    end
  end

  describe 'raw_info' do
    it 'should have pic_50 url' do
      allow(subject).to receive(:raw_info) { { 'has_pic' => '1', 'pic_50' => 'http://avt-17.foto.mail.ru/mail/test/_avatar50?111' } }

      expect(subject.info[:image]).to eq('http://avt-17.foto.mail.ru/mail/test/_avatar50?111')
    end

    it 'should have pic_small url' do
      allow(subject).to receive(:raw_info) { { 'has_pic' => '1', 'pic_small' => 'http://avt-17.foto.mail.ru/mail/test/_avatarsmall?111' } }

      expect(subject.info[:image]).to eq('http://avt-17.foto.mail.ru/mail/test/_avatarsmall?111')
    end

    it 'should not have pic url' do
      allow(subject).to receive(:raw_info) { { 'has_pic' => '0', 'pic_50' => 'http://avt-17.foto.mail.ru/mail/test/_avatar50?111', 'pic_small' => 'http://avt-17.foto.mail.ru/mail/test/_avatarsmall?111' } }

      expect(subject.info[:image]).to be_nil
    end
  end
end
