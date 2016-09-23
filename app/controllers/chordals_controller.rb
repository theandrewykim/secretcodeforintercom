class ChordalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!



	def accept_webhook
	  @body = request.body
      @headers = request.headers["X-Hub-Signature"]
	end
end
