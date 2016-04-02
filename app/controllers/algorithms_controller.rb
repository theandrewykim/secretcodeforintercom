class AlgorithmsController < ApplicationController

  def update
    answer = params[:algorithm][:answer]
    algorithm = Algorithm.find_by(id: params[:id])
    if algorithm.answer == answer
      flash[:notice] = "Good work! Here's your message..."
      secret = Secret.find_by(id: params[:algorithm][:secret_id])
      secret.solved = true
      secret.save
      redirect_to secret.message
    else
      flash[:notice] = "That was incorrect!"
      redirect_to :back
    end
  end

  def show
    @secret = Secret.find_by(id: params[:secret_id])
    @algorithm = Algorithm.find(params[:id])
  end

  def create
    redirect_to :back
  end

  def index
    redirect_to :back
  end

  def run_code
    @secret = Secret.find_by(id: params[:secret_id])
    @algorithm = Algorithm.find_by(id:params[:algorithm_id])
    Algorithm.convert_operators(params[:data])
    user_method = eval(params[:data])
    array_of_answers = @algorithm.caseanswers_to_array
    array_of_inputs = @algorithm.casetests_to_array
    incorrect_answers = []
    array_of_inputs.each_with_index do |inputs,idx|
      if method(user_method).call(inputs[0],inputs[1]) != array_of_answers[idx]
          incorrect_answers << [inputs[0],inputs[1]]
      end
    end
    @secret.update_attributes(solved: true)
    answer = incorrect_answers.empty?
    render 'algorithms/_run_code', locals: {answer: answer}, layout: false
  end
end
