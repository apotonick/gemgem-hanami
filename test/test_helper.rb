# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require "capybara_minitest_spec"
require "cell/testing"
Cell::Testing.capybara = true

require_relative '../config/environment'
require 'minitest/autorun'

Hanami::Application.preload!
