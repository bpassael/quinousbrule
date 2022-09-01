class AnnualFootprintsController < ApplicationController
  skip_before_action :authenticate_user!


  def create
    @footprint = AnnualFootprint.new(annual_footprint_params)
    #compute_total_plane
    #compute_total_transport_indiv
    #compute_total_public_transit
    #compute_total_home
    #compute_total_food
    #compute_total_consumption
    #compute_grand_total
    @footprint.save!
    redirect_to root_path
  end


  private

  def compute_total_plane
    self.fp_total_plane = 0
    if self.input_transport_plane?
      self.fp_total_plane += self.input_transport_flights_short * 2.5 * 461 * 0.259 # average hours per trip * average speed in kmh * fp per km
      self.fp_total_plane += self.input_transport_flights_middle * 6 * 540 * 0.187
      self.fp_total_plane += self.input_transport_flights_long * 20 * 682 * 0.152
    end
  end

  def compute_total_transport_indiv
    if self.input_transport_car?
      if (self.input_transport_car_type == "Petite"|| self.input_transport_car_type == "Moyenne") && self.input_transport_car_carburant == "Thermique"
        fp_construction = 5600 # total construction footprint
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

    if self.input_transport_car_age <= 1 # estimate annual amortization
      fp_am_construction = fp_construction * 0.4
    elsif car_age <= 2
      fp_am_construction = fp_construction * 0.2
    elsif car_age <= 10
      fp_am_construction = fp_construction * 0.05
    else
      fp_am_construction = 0
    end

    if self.input_transport_car_type == "Petite" && self.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.14 * self.input_transport_car_km # fp pr km * km per year
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

    fp_car = (fp_am_construction + fp_car_use) / self.input_transport_car_passengers # divide by average users

    fp_two_wheels = (self.input_transport_scooter_km * 0.08) + (self.input_transport_moto_km * 0.19) # km per year * fp per km

    self.fp_total_transport_indiv = fp_car + fp_two_wheels
  end

  def compute_total_public_transit
    fp_train = 0
    if self.input_transport_train?
      fp_train += self.input_transport_train_trips_short * 1.5 * 180  # average hours per trip * average speed in kmh * fp per km
      fp_train += self.input_transport_train_trips_middle * 4 * 200
      fp_train += self.input_transport_train_trips_long * 12 * 250
    end
    fp_bus = self.input_transport_bus_hours_week * 1.36 * 52 # hours per week * fp per hour * weeks in year
    fp_metro_tram = self.input_transport_metro_tram_hours_week * 0.08 * 52

    self.fp_total_public_transit = fp_train + fp_bus + fp_metro_tram
  end

  def compute_total_home
    unless :input_home_old? # if < 50 years, estimate annual amortization
      if self.input_home_type == "Appartement"
        fp_am_an = self.input_home_surface * 10.5
      elsif self.input_home_type == "Maison"
        fp_am_an = self.input_home_surface * 8.5
      elsif self.input_home_type == "Maison eco-construite"
        fp_am_an = self.input_home_surface * 2.88
      end
    else
      fp_am_an = 0
    end

    fp_elec = self.input_home_elec_monthly_bill * 62.08 * 0.06

    if self.input_home_heat_type == "Electricité ou pompe à chaleur"
      fp_heat = 0
    elsif self.input_home_heat_type == "Gaz"
      fp_heat = self.input_home_heat_bill * 115.08 * 0.227
    elsif self.input_home_heat_type == "Fioul"
      fp_heat = self.input_home_heat_bill * 13.5 * 3.5
    elsif self.input_home_heat_type == "Bois"
      fp_heat = self.input_home_heat_bill * 166.67 * 0.03
    end

    self.fp_total_home = (fp_am_an + fp_elec + fp_heat) / self.input_home_users
  end

  def compute_total_food
    if self.input_food_diet == "Vegan"
      self.fp_total_food = 284.7
    elsif self.input_food_diet == "Végétarien"
      self.fp_total_food = 354.8
    elsif self.input_food_diet == "Pescitarien"
      self.fp_total_food = 657
    elsif self.input_food_diet == "Je mange peu de viande"
      self.fp_total_food = 1064.7
    elsif self.input_food_diet == "Alimentation mixte"
      self.fp_total_food = 1641.04
    elsif self.input_food_diet == "Je mange beaucoup de viande"
      self.fp_total_food = 2456.45
    end

    self.fp_total_food += 153.3 if self.input_food_bottled_water?

    if self.input_food_waste == "Je suis zéro déchet"
      self.fp_total_food += 48
    elsif food_waste == "Je composte"
      self.fp_total_food += 183
    elsif food_waste == "Je réduis le gaspillage alimentaire"
      self.fp_total_food += 164
    elsif food_waste == "Je ne fais rien de particulier"
      self.fp_total_food += 194
    end
  end

  def compute_total_consumption
    if self.input_consumption_tech == "Beaucoup"
      self.fp_total_consumption = 500
    elsif self.input_consumption_tech == "Moyennement"
      self.fp_total_consumption = 220
    elsif self.input_consumption_tech == "Peu"
      self.fp_total_consumption = 90
    end

    if self.input_consumption_appliances == "Beaucoup"
      self.fp_total_consumption += 350 / self.input_home_users
    elsif self.input_consumption_appliances == "Moyennement"
      self.fp_total_consumption += 130 / self.input_home_users
    elsif self.input_consumption_appliances == "Peu"
      self.fp_total_consumption += 50 / self.input_home_users
    end

    if self.input_consumption_clothing == "Très souvent"
      self.fp_total_consumption += 550
    elsif self.input_consumption_clothing == "Régulièrement"
      self.fp_total_consumption += 386
    elsif self.input_consumption_clothing == "Occasionnellement"
      self.fp_total_consumption += 223
    elsif self.input_consumption_clothing == "Rarement"
      self.fp_total_consumption += 60
    end
  end

  def compute_grand_total
    self.annual_footprint_kgCO2e = self.fp_total_plane + self.fp_total_transport_indiv + self.fp_total_public_transit + self.fp_total_home + self.fp_total_food + self.fp_total_consumption + 1113
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
                                             :input_home_heat_type,
                                             :input_home_elec_monthly_bill,
                                             :input_home_heat_bill,
                                             :input_home_users,
                                             :fp_total_home,
                                             :input_food_diet,
                                             :input_food_waste,
                                             :input_food_bottled_water?,
                                             :fp_total_food,
                                             :input_consumption_tech,
                                             :input_consumption_appliances,
                                             :input_consumption_clothing,
                                             :fp_total_consumption)
  end
end
