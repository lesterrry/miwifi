# Handcrafted by Aydar N.
# 2023
#
# me@aydar.media
#

# frozen_string_literal: true

require 'test_helper'

# Tests basic functionality
class MiwifiAuthTest < Minitest::Test

	@@ip = ENV['MIWIFI_IP']
	@@password = ENV['MIWIFI_PWD']

	def test_incorrect_credentials
		skip
		router = Miwifi::Router.new(@@ip, 'amogus')

		assert_raises(Miwifi::AccessDeniedError) { router.auth }
	end

	def test_correct_credentials
		router = Miwifi::Router.new(@@ip, @@password)
		router.auth

		p "Got token: #{router.token}"
		refute_empty router.token
	end
end
