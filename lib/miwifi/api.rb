# Handcrafted by Aydar N.
# 2022-2023
#
# me@aydar.media
#

# frozen_string_literal: true

module Miwifi

	class Router
		def device_list
			raise Miwifi::NoTokenError if @token.nil?

			uri = URI.parse("http://#{@ip}/cgi-bin/luci/;stok=#{@token}/api/misystem/devicelist")
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