class AnnualFootprintsController < ApplicationController
  skip_before_action :authenticate_user!


  def create
    @footprint = AnnualFootprint.new(annual_footprint_params)
    compute_total_plane
    compute_total_transport_indiv
    compute_total_public_transit
    compute_total_home
    compute_total_food
    compute_total_consumption
    compute_grand_total
    @footprint.save!
    @current_id = @footprint.id
    # redirect_to root_path
  end


  private

  def compute_total_plane
    @footprint.fp_total_plane = 0
    if @footprint.input_transport_plane?
      @footprint.fp_total_plane += @footprint.input_transport_flights_short * 2.5 * 461 * 0.259 # average hours per trip * average speed in kmh * fp per km
      @footprint.fp_total_plane += @footprint.input_transport_flights_middle * 6 * 540 * 0.187
      @footprint.fp_total_plane += @footprint.input_transport_flights_long * 20 * 682 * 0.152
    end
  end

  def compute_total_transport_indiv
    if @footprint.input_transport_car?
      if (@footprint.input_transport_car_type == "Petite" || @footprint.input_transport_car_type == "Moyenne") && @footprint.input_transport_car_carburant == "Thermique"
        fp_construction = 5600 # total construction footprint
      elsif (@footprint.input_transport_car_type == "Berline" || @footprint.input_transport_car_type == "SUV") && @footprint.input_transport_car_carburant == "Thermique"
        fp_construction = 6300
      elsif (@footprint.input_transport_car_type == "Petite" || @footprint.input_transport_car_type == "Moyenne") && @footprint.input_transport_car_carburant == "Hybride"
        fp_construction = 7600
      elsif (@footprint.input_transport_car_type == "Berline" || @footprint.input_transport_car_type == "SUV") && @footprint.input_transport_car_carburant == "Hybride"
        fp_construction = 8550
      elsif (@footprint.input_transport_car_type == "Petite" || @footprint.input_transport_car_type == "Moyenne") && @footprint.input_transport_car_carburant == "Electrique"
        fp_construction = 8000
      elsif (@footprint.input_transport_car_type == "Berline" || @footprint.input_transport_car_type == "SUV") && @footprint.input_transport_car_carburant == "Electrique"
        fp_construction = 13600
      end
    end

    if @footprint.input_transport_car_age <= 1 # estimate annual amortization
      fp_am_construction = fp_construction * 0.4
    elsif @footprint.input_transport_car_age <= 2
      fp_am_construction = fp_construction * 0.2
    elsif @footprint.input_transport_car_age <= 10
      fp_am_construction = fp_construction * 0.05
    else
      fp_am_construction = 0
    end

    if @footprint.input_transport_car_type == "Petite" && @footprint.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.14 * @footprint.input_transport_car_km # fp pr km * km per year
    elsif @footprint.input_transport_car_type == "Moyenne" && @footprint.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.16 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Berline" && @footprint.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.19 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "SUV" && @footprint.input_transport_car_carburant == "Thermique"
      fp_car_use = 0.22 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Petite" && @footprint.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.12 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Moyenne" && @footprint.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.135 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Berline" && @footprint.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.16 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "SUV" && @footprint.input_transport_car_carburant == "Hybride"
      fp_car_use = 0.187 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Petite" && @footprint.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.02 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Moyenne" && @footprint.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.02 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "Berline" && @footprint.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.03 * @footprint.input_transport_car_km
    elsif @footprint.input_transport_car_type == "SUV" && @footprint.input_transport_car_carburant == "Electrique"
      fp_car_use = 0.03 * @footprint.input_transport_car_km
    end

    fp_car = (fp_am_construction + fp_car_use) / @footprint.input_transport_car_passengers # divide by average users

    fp_two_wheels = (@footprint.input_transport_scooter_km * 0.08) + (@footprint.input_transport_moto_km * 0.19) # km per year * fp per km

    @footprint.fp_total_transport_indiv = fp_car + fp_two_wheels
  end

  def compute_total_public_transit
    fp_train = 0
    if @footprint.input_transport_train?
      fp_train += @footprint.input_transport_train_trips_short * 1.5 * 180 * 0.02  # nbr of trips * average hours per trip * average speed in kmh * fp per km
      fp_train += @footprint.input_transport_train_trips_middle * 4 * 200 * 0.02
      fp_train += @footprint.input_transport_train_trips_long * 10 * 250 * 0.02
    end
    fp_bus = @footprint.input_transport_bus_hours_week * 1.36 * 52 # hours per week * fp per hour * weeks in year
    fp_metro_tram = @footprint.input_transport_metro_tram_hours_week * 0.08 * 52

    @footprint.fp_total_public_transit = fp_train + fp_bus + fp_metro_tram
  end

  def compute_total_home
    unless @footprint.input_home_old? # if < 50 years, estimate annual amortization
      if @footprint.input_home_type == "Appartement"
        fp_am_an = @footprint.input_home_surface * 10.5
      elsif @footprint.input_home_type == "Maison"
        fp_am_an = @footprint.input_home_surface * 8.5
      elsif @footprint.input_home_type == "Maison eco-construite"
        fp_am_an = @footprint.input_home_surface * 2.88
      end
    else
      fp_am_an = 0
    end

    fp_elec = @footprint.input_home_elec_monthly_bill * 62.08 * 0.06

    if @footprint.input_home_heat_type == "Electricité ou pompe à chaleur"
      fp_heat = 0
    elsif @footprint.input_home_heat_type == "Gaz"
      fp_heat = @footprint.input_home_heat_bill * 115.08 * 0.227
    elsif @footprint.input_home_heat_type == "Fioul"
      fp_heat = @footprint.input_home_heat_bill * 13.5 * 3.5
    elsif @footprint.input_home_heat_type == "Bois"
      fp_heat = @footprint.input_home_heat_bill * 166.67 * 0.03
    end

    @footprint.fp_total_home = (fp_am_an + fp_elec + fp_heat) / @footprint.input_home_users
  end

  def compute_total_food
    if @footprint.input_food_diet == "Vegan"
      @footprint.fp_total_food = 284.7
    elsif @footprint.input_food_diet == "Végétarien"
      @footprint.fp_total_food = 354.8
    elsif @footprint.input_food_diet == "Pescitarien"
      @footprint.fp_total_food = 657
    elsif @footprint.input_food_diet == "Je mange peu de viande"
      @footprint.fp_total_food = 1064.7
    elsif @footprint.input_food_diet == "Alimentation mixte"
      @footprint.fp_total_food = 1641.04
    elsif @footprint.input_food_diet == "Je mange beaucoup de viande"
      @footprint.fp_total_food = 2456.45
    end

    @footprint.fp_total_food += 153.3 if @footprint.input_food_bottled_water?

    if @footprint.input_food_waste == "Je suis zéro déchet"
      @footprint.fp_total_food += 48
    elsif @footprint.input_food_waste == "Je composte"
      @footprint.fp_total_food += 183
    elsif @footprint.input_food_waste == "Je réduis le gaspillage alimentaire"
      @footprint.fp_total_food += 164
    elsif @footprint.input_food_waste == "Je ne fais rien de particulier"
      @footprint.fp_total_food += 194
    end
  end

  def compute_total_consumption
    if @footprint.input_consumption_tech == "Beaucoup"
      @footprint.fp_total_consumption = 500
    elsif @footprint.input_consumption_tech == "Moyennement"
      @footprint.fp_total_consumption = 220
    elsif @footprint.input_consumption_tech == "Peu"
      @footprint.fp_total_consumption = 90
    end

    if @footprint.input_consumption_appliances == "Beaucoup"
      @footprint.fp_total_consumption += 350 / @footprint.input_home_users
    elsif @footprint.input_consumption_appliances == "Moyennement"
      @footprint.fp_total_consumption += 130 / @footprint.input_home_users
    elsif @footprint.input_consumption_appliances == "Peu"
      @footprint.fp_total_consumption += 50 / @footprint.input_home_users
    end

    if @footprint.input_consumption_clothing == "Très souvent"
      @footprint.fp_total_consumption += 550
    elsif @footprint.input_consumption_clothing == "Régulièrement"
      @footprint.fp_total_consumption += 386
    elsif @footprint.input_consumption_clothing == "Occasionnellement"
      @footprint.fp_total_consumption += 223
    elsif @footprint.input_consumption_clothing == "Rarement"
      @footprint.fp_total_consumption += 60
    end
  end

  def compute_grand_total
    @footprint.annual_footprint_kgCO2e = @footprint.fp_total_plane + @footprint.fp_total_transport_indiv + @footprint.fp_total_public_transit + @footprint.fp_total_home + @footprint.fp_total_food + @footprint.fp_total_consumption + 1113
  end


  def annual_footprint_params
    params.require(:annual_footprint).permit(
                                             :input_transport_plane,
                                             :input_transport_flights_short,
                                             :input_transport_flights_middle,
                                             :input_transport_flights_long,
                                             :fp_total_plane,
                                             :input_transport_car,
                                             :input_transport_car_type,
                                             :input_transport_car_carburant,
                                             :input_transport_car_age,
                                             :input_transport_car_passengers,
                                             :input_transport_car_km,
                                             :input_transport_two_wheels,
                                             :input_transport_scooter_km,
                                             :input_transport_moto_km,
                                             :fp_total_transport_indiv,
                                             :input_transport_train,
                                             :input_transport_train_trips_short,
                                             :input_transport_train_trips_middle,
                                             :input_transport_train_trips_long,
                                             :input_transport_bus_hours_week,
                                             :input_transport_metro_tram_hours_week,
                                             :fp_total_public_transit,
                                             :input_home_surface,
                                             :input_home_old,
                                             :input_home_type,
                                             :input_home_heat_type,
                                             :input_home_elec_monthly_bill,
                                             :input_home_heat_bill,
                                             :input_home_users,
                                             :fp_total_home,
                                             :input_food_diet,
                                             :input_food_waste,
                                             :input_food_bottled_water,
                                             :fp_total_food,
                                             :input_consumption_tech,
                                             :input_consumption_appliances,
                                             :input_consumption_clothing,
                                             :fp_total_consumption,
                                             :annual_footprint_kgCO2e
                                            )
  end
end
