class ChordalsController < ApplicationController

	def accept_webhook
		@body = request.body
    @headers = request.headers
    print
	end
end
