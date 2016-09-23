class ChordalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!



	def accept_webhook
      @headers = request.headers
      @body = request.body.read
      secret_hash = @headers["HTTP_X_HUB_SIGNATURE"]
      verify_signature(@body, secret_hash)
   	  render :nothing => true
	end

	private

    def verify_signature(payload_body, secret_hash)
    	data = payload_body
    	key = ENV["HUB_SECRET"]
    	digest = OPENSSL::Digest.new('sha1')
    	hmac = OpenSSL::HMAC.hexdigest(digest, key, data)
    	raise "error" if hmac != secret_hash
    end

end
