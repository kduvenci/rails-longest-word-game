require 'net/http'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].tr(" ", "")
    @answer = params[:answer]
    @orginal = true;
    @message = ""

    @answer.each_char do |chr|
      if @answer.scan(/#{chr}/).count > @letters.scan(/#{chr}/).count
        @orginal = false;
        @message = "No cheating! Letters are not in the orginal grid."
      end
    end

    if @orginal
      url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      @json_answer = JSON.parse(response)
      
      if @json_answer["found"]
        @message = "Perfect! Your score is #{@answer.size * @answer.size}"
      else
        @message = "Nice try but word does not exist in English."
      end
    end
  end
end
