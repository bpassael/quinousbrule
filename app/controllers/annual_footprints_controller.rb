class AnnualFootprintsController < ApplicationController

  def create
    @footprint = AnnualFootprint.new(params[:annual_footprint])
    ## compute (subtotals and) grand total in private methods
    @footprint.save
  end


  private

  def annual_footprint_params
    params.require(:annual_footprint).permit(:annual_footprint_kgCO2e,
                                             :input_transport_plane?,
                                             :input_transport_flights_short,
                                             :input_transport_flights_middle,
                                             :input_transport_flights_long,
                                             :fp_total_plane,
                                             :input_transport_car?,
                                             :input_transport_car_type,
                                             :input_transport_car_carburant,
                                             :input_transport_car_age,
                                             :input_transport_car_passengers,
                                             :input_transport_car_km,
                                             :input_transport_two_wheels,
                                             :input_transport_scooter_km,
                                             :input_transport_moto_km,
                                             :fp_total_transport_indiv,
                                             :input_transport_train?,
                                             :input_transport_train_trips_short,
                                             :input_transport_train_trips_middle,
                                             :input_transport_train_trips_long,
                                             :input_transport_bus_hours_week,
                                             :input_transport_metro_tram_hours_week,
                                             :fp_total_public_transit,
                                             :input_home_surface,
                                             :input_home_old?,
                                             :input_home_type,
                                             :input_home_low_cons?,
                                             :input_home_heat_type,
                                             :input_home_elec_monthly_bill,
                                             :input_home_heat_bill,
                                             :input_home_users,
                                             :fp_total_home,
                                             :input_food_diet,
                                             :input_food_waste,
                                             :fp_total_food,
                                             :input_consumption_tech,
                                             :input_consumption_appliances,
                                             :input_consumption_clothing,
                                             :fp_total_consumption)
  end

end
