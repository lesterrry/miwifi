# 
# COPYRIGHT LESTER COVEY,
#
# 2022

module Miwifi

	class Router
		def device_list
			if @token.nil? then raise Miwifi::NoTokenError end
			uri = URI.parse("http://#{@ip}/cgi-bin/luci/;stok=#{@token}/api/misystem/devicelist")
			r = Request::default(uri, false)
			return Request.json_make(r, uri)
		end
	end

	class Request
		def self.json_make(r, uri)
			response = Net::HTTP.start(uri.hostname, uri.port) do |http|
				http.request(r)
			end
			parsed = JSON.parse(response.body)
			if parsed["code"] == 401 then raise Miwifi::AccessDeniedError
			elsif parsed["code"] != 0 then raise Miwifi::UnexpectedResponseCodeError end
			return parsed
		end
	end

end