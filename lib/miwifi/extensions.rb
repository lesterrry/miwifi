# 
# COPYRIGHT LESTER COVEY,
#
# 2022

class String
	def between(start, finish)
		self[/#{Regexp.escape(start)}(.*?)#{Regexp.escape(finish)}/m, 1]
	end
end