lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/mail_ru/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-mail_ru'
  spec.version       = OmniAuth::MailRu::VERSION
  spec.authors       = ['Andrey Skuryatin']
  spec.email         = ['andrey.skuryatin@gmai.com']
  spec.summary       = 'OmniAuth strategy for Mail.ru'
  spec.description   = 'OmniAuth strategy for Mail.ru'
  spec.homepage      = 'https://github.com/andrey-skat/omniauth-mail_ru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth-oauth2', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49'
end
