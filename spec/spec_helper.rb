require "bundler"
Bundler.setup

require 'active_record'
require File.expand_path("../../lib/district_cn",  __FILE__)
require 'rspec/autorun'
#require 'active_support/core_ext/kernel/reporting'
require 'logger'

require 'coveralls'
Coveralls.wear!

