class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @measurements = Measurement.all
    @footprint = AnnualFootprint.new
  end


end
