# Handcrafted by Aydar N.
# 2022-2023
#
# me@aydar.media
#

# frozen_string_literal: true

class String
	def between(start, finish)
		self[/#{Regexp.escape(start)}(.*?)#{Regexp.escape(finish)}/m, 1]
	end
end