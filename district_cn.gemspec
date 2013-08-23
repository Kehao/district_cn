# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'district_cn/version'

Gem::Specification.new do |spec|
  spec.name          = "district_cn"
  spec.version       = DistrictCn::VERSION
  spec.authors       = ["kehao"]
  spec.email         = ["kehao.qiu@gmail.com"]
  spec.description   = %q{地区码查询}
  spec.summary       = %q{地区码查询}
#  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'activesupport', '~> 3.2.6'
  spec.add_dependency 'json', '~> 1.7.5'
end
