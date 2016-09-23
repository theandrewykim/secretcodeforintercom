class ChordalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token, :authenticate_user!



	def accept_webhook
	  @body = request.body.read
	  verify_signature(@body)
      @headers = request.headers
      p @headers
      render :nothing => true
      push = JSON.parse(params[:payload])
  	  puts "chord received #{push.inspect}"
	end

    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['HUB_SECRET'], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end

end
