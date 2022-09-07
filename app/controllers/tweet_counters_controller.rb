class TweetCountersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def update
    @tweet_counter = TweetCounter.first
    @tweet_counter.count += 1
    @tweet_counter.save!

    # respond_to do |format|
    #   format.html { redirect_to tweet_counter_path }
    #   format.text { render partial: "partials/community", locals: {tweet_counter: @tweet_counter}, formats: [:html] }
    # end
  end

end
