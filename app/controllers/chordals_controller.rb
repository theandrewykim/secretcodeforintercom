class ChordalsController < ApplicationController

	def accept_webhook
		@body = request.body
	end
end
