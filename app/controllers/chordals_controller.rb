class ChordalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!



	def accept_webhook4
      @headers = request.headers
      @body = request.body.read
      p @body
      p @headers["HTTP_X_HUB_SIGNATURE"]
  	  render :nothing => true
	end

    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['HUB_SECRET'], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end

end
