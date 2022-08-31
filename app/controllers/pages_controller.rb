class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @measurements = Measurement.all
    @footprint = AnnualFootprint.new
  end
end
