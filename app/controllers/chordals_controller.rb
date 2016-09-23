class ChordalsController < ApplicationController

	def accept_webhook
		@body = request.body
    @headers = request.headers
    flash.now.notice = "message recieved"
	end
end
