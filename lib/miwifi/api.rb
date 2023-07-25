# Handcrafted by Aydar N.
# 2022-2023
#
# me@aydar.media
#

# frozen_string_literal: true

module Miwifi

	class Router
		def device_list
			generic_api_request "http://#{@ip}/cgi-bin/luci/;stok=#{@token}/api/misystem/devicelist"
		end

		def reboot
			generic_api_request "http://#{@ip}/cgi-bin/luci/;stok=#{@token}/api/misystem/reboot"
		end

			private

		def generic_api_request(uri_string)
			raise Miwifi::NoTokenError if @token.nil?

			uri = URI.parse(uri_string)
			r = Request.default(uri, false)
			Request.json_make(r, uri)
		end
	end

	class Request
		def self.json_make(r, uri)
			response = Net::HTTP.start(uri.hostname, uri.port) do |http|
				http.request(r)
			end
			parsed = JSON.parse(response.body)
			raise Miwifi::AccessDeniedError if parsed['code'] == 401
			raise Miwifi::UnexpectedResponseCodeError if parsed['code'] != 0

			parsed
		end
	end

end