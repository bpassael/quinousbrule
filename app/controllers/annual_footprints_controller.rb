class AnnualFootprintsController < ApplicationController

  def create
    @footprint = AnnualFootprint.new(annual_footprint_params)
    compute_total_plane
    compute_total_transport_indiv
    compute_total_public_transit
    compute_total_home
    compute_total_food
    compute_total_consumption
    compute_grand_total
    @footprint.save
  end


  private


  def compute_total_plane
    self.fp_total_plane = 0
    if self.input_transport_plane?
      self.fp_total_plane += self.input_transport_flights_short * 2.5 * 461 * 0.259
      self.fp_total_plane += self.input_transport_flights_middle * 6 * 540 * 0.187
      self.fp_total_plane += self.input_transport_flights_long * 20 * 682 * 0.152
  end

  def compute_total_transport_indiv
    self.fp_total_transport_indiv = 0

    if self.input_transport_car?
      if (self.input_transport_car_type == "Petite"|| self.input_transport_car_type == "Moyenne") && self.input_transport_car_carburant == "Thermique"
        fp_construction = 5600
      elsif (self.input_transport_car_type == "Berline"|| self.input_transport_car_type == "SUV") && self.input_transport_car_carburant == "Thermique"
        fp_construction = 6300
      elsif (self.input_transport_car_type == "Petite"|| self.input_transport_car_type == "Moyenne") && self.input_transport_car_carburant == "Hybride"
        fp_construction = 7600
      elsif (self.input_transport_car_type == "Berline"|| self.input_transport_car_type == "SUV") && self.input_transport_car_carburant == "Hybride"
        fp_construction = 8550
      elsif (self.input_transport_car_type == "Petite"|| self.input_transport_car_type == "Moyenne") && self.input_transport_car_carburant == "Electrique"
        fp_construction = 8000
      elsif (self.input_transport_car_type == "Berline"|| self.input_transport_car_type == "SUV") && self.input_transport_car_carburant == "Electrique"
        fp_construction = 13600
      end
    end

    if self.input_transport_car_age <= 1
      fp_am_construction = fp_construction * 0.4
    elsif car_age <= 2
      fp_am_construction = fp_construction * 0.2
    elsif car_age <= 10
      fp_am_construction = fp_construction * 0.05
    else
      fp_am_construction = 0
    end

    if self.input_transport_car_type == "Petite" && self.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.14 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Moyenne" && self.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.16 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Berline" && self.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.19 * self.input_transport_car_km
    elsif self.input_transport_car_type == "SUV" && self.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.22 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Petite" && self.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.12 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Moyenne" && self.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.135 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Berline" && self.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.16 * self.input_transport_car_km
    elsif self.input_transport_car_type == "SUV" && self.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.187 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Petite" && self.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.02 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Moyenne" && self.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.02 * self.input_transport_car_km
    elsif self.input_transport_car_type == "Berline" && self.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.03 * self.input_transport_car_km
    elsif self.input_transport_car_type == "SUV" && self.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.03 * self.input_transport_car_km
    end

    fp_car = (fp_am_construction + fp_car_use) / self.input_transport_car_passengers

    fp_two_wheels = (self.input_transport_scooter_km * 0.08) + (self.input_transport_moto_km * 0.19)

    self.fp_total_transport_indiv += fp_car + fp_two_wheels
  end

  def compute_total_public_transit
    fp_train = 0
    if self.input_transport_train?
      fp_train += self.input_transport_train_trips_short * 1.5 * 180
      fp_train += self.input_transport_train_trips_middle * 4 * 200
      fp_train += self.input_transport_train_trips_long * 12 * 250
    end
    fp_bus = self.input_transport_bus_hours_week * 1.36 * 52
    fp_metro_tram = self.input_transport_metro_tram_hours_week * 0.08 * 52

    self.fp_total_public_transit = fp_train + fp_bus + fp_metro_tram
  end

  def compute_total_home
  end

  def compute_total_food
  end

  def compute_total_consumption
  end

  def compute_grand_total
    self.annual_footprint_kgCO2e = self.fp_total_plane + self.fp_total_transport_indiv + self.fp_total_public_transit + self.fp_total_home + self.fp_total_food + self.fp_total_consumption
  end


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
