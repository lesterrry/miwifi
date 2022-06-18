# 
# COPYRIGHT LESTER COVEY,
#
# 2022

require "net/http"
require "digest/sha1"
require "uri"
require "json"

module Miwifi

	class Router
		def initialize(ip, password, username="admin")
			@ip = ip
			@password = password
			@username = username
			@token = nil
		end
		def auth
			uri = URI.parse("http://#{@ip}/cgi-bin/luci/web/home")
			r = Net::HTTP::Get.new(uri)
			response = Net::HTTP.start(uri.hostname, uri.port) do |http|
				http.request(r)
			end
			# TODO:
			# This is unsafe as hell but bruh nobody even pays me
			key = response.body.between("key: '", "',")
			iv = response.body.between("iv: '", "',")
			device_id = response.body.between("deviceId = '", "';")
			time = Time.now.to_i
			random = rand(1000..9000)
			nonce = "0_#{device_id}_#{time}_#{random}"
			pass = Digest::SHA1.hexdigest(nonce + Digest::SHA1.hexdigest(@password + key))
			uri = URI.parse("http://#{@ip}/cgi-bin/luci/api/xqsystem/login")
			r = Request::default(uri, true)
			r.set_form_data(
				"logtype" => "2",
				"nonce" => nonce,
				"password" => pass,
				"username" => @username,
			)
			response = Net::HTTP.start(uri.hostname, uri.port) do |http|
				http.request(r)
			end
			parsed = JSON.parse(response.body)
			if parsed["code"] == 401 then raise Miwifi::AccessDeniedError
			elsif parsed["code"] != 0 then raise Miwifi::UnexpectedResponseCodeError end
			@token = parsed["token"]
		end
		def bury_token(f)
			if @token.nil? then raise Miwifi::NoTokenError end
			File.open(f, 'wb') do |f|
				f.write(Marshal.dump(@token))
			end
		end
		def restore_token(f)
			file_data = File.read(f)
			@token = Marshal.load(file_data)
		end
	end

	class Request
		def self.default(uri, post)
			request = post ? Net::HTTP::Post.new(uri) : Net::HTTP::Get.new(uri)
			if post then request.content_type = "application/x-www-form-urlencoded; charset=UTF-8" end
			request["Accept"] = "*/*"
			request["Accept-Language"] = "ru"
			request["Host"] = uri.host
			request["Origin"] = "http://#{uri.host}"
			request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15"
			request["Connection"] = "keep-alive"
			request["Referer"] = "http://#{uri.host}/cgi-bin/luci/web"
			request["Cookie"] = "monitor_count=1"
			request["X-Requested-With"] = "XMLHttpRequest"
			return request
		end
	end

end