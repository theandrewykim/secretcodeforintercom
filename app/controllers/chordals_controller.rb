class ChordalsController < ApplicationController

	def accept_webhook
		@body = request.body
    @headers = request.headers
    flash[:notice] = "message recieved"
    redirect_to root_path
	end
end
