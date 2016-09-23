class ChordalController < ApplicationController

	def accept_webhook
		@body = request.body
		redirect_to root_path
	end
end
