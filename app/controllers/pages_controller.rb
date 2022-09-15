class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @measurements = Measurement.all
    @footprint = AnnualFootprint.new
    @tweet_counter = TweetCounter.first
    @mail_counter = MailCounter.first
  end

  def tweetallreps
    @reps = JSON.parse(File.read(Rails.root.join('public', 'deputes.json')))
  end

end
