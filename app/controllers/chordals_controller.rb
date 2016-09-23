class ChordalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!



	def accept_webhook
		@body = request.body
    @headers = request.headers
    flash.now[:notice] = "woooo"
    redirect_to "user"
	end
end
