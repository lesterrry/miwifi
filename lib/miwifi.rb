# Handcrafted by Aydar N.
# 2022-2023
#
# me@aydar.media
#

# frozen_string_literal: true

require_relative 'miwifi/version'
require_relative 'miwifi/extensions'
require_relative 'miwifi/router'
require_relative 'miwifi/api'

module Miwifi

	class AccessDeniedError < StandardError
		def initialize(msg = 'Access denied; check your credentials', exception_type = 'custom')
			@exception_type = exception_type
			super(msg)
		end
	end

	class UnexpectedResponseCodeError < StandardError
		def initialize(msg = 'Got unexpected response code. Please report this behavior', exception_type = 'custom')
			@exception_type = exception_type
			super(msg)
		end
	end

	class NoTokenError < StandardError
		def initialize(msg = 'You are unauthorized', exception_type = 'custom')
			@exception_type = exception_type
			super(msg)
		end
	end

end
