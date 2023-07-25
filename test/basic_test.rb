# Handcrafted by Aydar N.
# 2023
#
# me@aydar.media
#

# frozen_string_literal: true

require 'test_helper'

$ip = ENV['MIWIFI_IP']
$password = ENV['MIWIFI_PWD']
$token = nil

Minitest::Test.i_suck_and_my_tests_are_order_dependent!

# Tests token retrieving and basic requests
class MiwifiBasicTest < Minitest::Test

	def test_incorrect_auth
		refute_nil $ip
		router = Miwifi::Router.new($ip, 'amogus')

		assert_raises(Miwifi::AccessDeniedError) { router.auth }
	end

	def test_correct_auth
		refute_nil $ip; refute_nil $password
		router = Miwifi::Router.new($ip, $password)
		router.auth

		refute_empty router.token

		p "Got token: #{router.token}"
		$token = router.token
	end

	def test_devices_list
		refute_nil $ip; refute_nil $password; refute_nil $token

		router = Miwifi::Router.new($ip, $password, token: $token)
		list = router.device_list

		refute_empty list
	end

end

# Tests token caching
class MiwifiCacheTest < Minitest::Test

	def test_token_cache
		file = './test_token.bin'
		router = Miwifi::Router.new('1.1.1.1', '1234', token: '4321')
		router.bury_token file

		new_router = Miwifi::Router.new('1.1.1.1', '1234')
		new_router.restore_token file

		assert_equal '4321', new_router.token
	end

end
