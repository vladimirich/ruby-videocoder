# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ruby_videocoder/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-videocoder'
  spec.version       = VideoCoder::VERSION
  spec.authors       = ['vladimirich']
  spec.email         = ['nikskalkin@gmail.com']
  spec.description   = 'Ruby gem for video encoding'
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rubocop'

  spec.requirements << 'ffmpeg configured with libx264 and libfaac'
end
