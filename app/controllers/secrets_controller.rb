class SecretsController < ApplicationController

  def create
    secret = Secret.new(secret_params)
    if secret.save
      flash[:notice] = "Your secret was sent! Shhhhhh..."
      redirect_to current_user
    else
      flash[:notice] = "Oops! Something went wrong..."
      redirect_to :back
    end
  end

  def showx
    @secret = Secret.find_by(id: params[:id])
    if @secret.solved || current_user == @secret.sender
      @message = @secret.message
      redirect_to @message
    else
      redirect_to algorithm_path(id: @secret.algorithm.id, secret_id: @secret.id)
    end
  end

  private

  def secret_params
    algorithms = Algorithm.all
    algorithm = algorithms.sample
    params.permit(:receiver_id, :message_id).merge(sender: current_user, algorithm: algorithm)
  end


end
