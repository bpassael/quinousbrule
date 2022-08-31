
# Version beta sur terminal du comparateur empreinte carbone annuel pour quinousbrule
# Work in progress, tout est à affiner et à vérifier

# OBJECTIF

# Se baser les méthodes de calcul (publiques) du comparateur d'Avenir Climatique qui utilise quasi exclusivement les données de l’ADEME
# https://avenirclimatique.org/calculer-empreinte-carbone/

# Viser la simplicité du questionnaire de Carbo (mais leur méthode de calcul n'est pas publique)
# app.hellocarbo.com



total_footprint = 0

puts '----------------------------------------'
puts 'CALCULATEUR EMPREINTE CARBONE ANNUELLE'
puts '----------------------------------------'

puts 'JE ME DEPLACE'
puts '----------------------------------------'


### AVION


plane = ""
until plane == "Y" || plane == "N"
  puts "Prenez-vous l'avion ? (Y/N)"
  plane = gets.chomp.capitalize
end
if plane == "Y"
  puts "Combien de vols domestiques AR dans l'année ?"
  flight_hours_short = gets.chomp.to_i * 2.5 # estimation durée d'un AR dans la catégorie
  puts "Combien de vols moyen courrier AR dans l'année (dans un autre pays d'Europe par exemple) ?"
  flight_hours_middle = gets.chomp.to_i * 6
  puts "Combien de vols long courrier AR dans l'année (vol international) ?"
  flight_hours_long = gets.chomp.to_i * 20

    # possibilité de demander par nombre d'heures pour plus de précision
    # puts "Combien d'heures de vol domestique dans l'année ?"
    # flight_hours_short = gets.chomp.to_i
    # puts "Combien d'heures de vol moyen courrier dans l'année ?"
    # flight_hours_middle = gets.chomp.to_i
    # puts "Combien d'heures de vol long courrier dans l'année ?"
    # flight_hours_long = gets.chomp.to_i



  const_speed_short = 461 # km/h
  const_speed_middle = 540 # km/h
  const_speed_long = 682 # km/h


  fp_per_km_short = 0.259
  fp_per_km_middle = 0.187
  fp_per_km_long = 0.152

  # calcul pour court/moyen/long : heures * average speed * fp per km

  fp_plane = flight_hours_short * const_speed_short * fp_per_km_short
  fp_plane += flight_hours_middle * const_speed_middle * fp_per_km_middle
  fp_plane += flight_hours_long * const_speed_long * fp_per_km_long

  puts "Total avion : #{fp_plane} kg CO2e"


  total_footprint += fp_plane

end

### VOITURE

car = ""
until car == "Y" || car == "N"
  puts "Utilisez vous une voiture ? (Y/N)"
  car = gets.chomp.capitalize
end
if car == "Y"

  puts 'Quel type de voiture ? 1 : Petite, 2 : Moyenne, 3 : Berline, 4 : SUV'
  car_type = gets.chomp.to_i
  puts "Quel type de carburant ? 1 : Thermique, 2 : Hybride, 3 : Electrique"
  car_carb = gets.chomp.to_i
  puts "Quel âge a la voiture (en années ?)"
  car_age = gets.chomp.to_i
  puts "Combien de passagers en moyenne ?"
  car_users = gets.chomp.to_f
  puts "Combien de km parcourus sur l'année ?"
  car_km = gets.chomp.to_f

  ## Amortissement construction

  # construction : thermique petite ou moyenne : 5600 kgCO2e
  # construction : thermique berline ou SUV : 6300 kgCO2e
  # construction : hybride petite ou moyenne : 7600 kgCO2e
  # construction : hybride berline ou SUV : 8550 kgCO2e
  # construction : electrique petite ou moyenne : 8000 kgCO2e
  # construction : electrique berline ou SUV : 13600 kgCO2e

  # % ammortissement : *40% si moins d’un an, *20% si moins de 2 ans, *5% si moins de 10 ans, 0% après (on considère que c'est déjà amorti)
  # (default avclim : moyenne / thermique / 9 ans)


  if (car_type == 1 || car_type == 2) && car_carb == 1
    footprint_construction = 5600
  elsif (car_type == 3 || car_type == 4) && car_carb == 1
    footprint_construction = 6300
  elsif (car_type == 1 || car_type == 2) && car_carb == 2
    footprint_construction = 7600
  elsif (car_type == 3 || car_type == 4) && car_carb == 2
    footprint_construction = 8550
  elsif (car_type == 1 || car_type == 2) && car_carb == 3
    footprint_construction = 8000
  elsif (car_type == 3 || car_type == 4) && car_carb == 3
    footprint_construction = 13600
  else
    p "WRONG INPUT"
    exit
  end

  if car_age <= 1
    fp_am_construction = footprint_construction * 0.4
  elsif car_age <= 2
    fp_am_construction = footprint_construction * 0.2
  elsif car_age <= 10
    fp_am_construction = footprint_construction * 0.05
  else
    fp_am_construction = 0
  end

  ## Utilisation

  # empreinte au km

  # thermique petite 0.14
  # thermique moyenne 0.16
  # thermique berline 0.19
  # thermique suv 0.22

  # hybride petite 0.12
  # hybride moyenne 0.135
  # hybride berline 0.16
  # hybride SUV 0.187

  # electrique petite 0.02
  # electrique moyenne 0.02
  # electrique berline 0.03
  # electrique SUV 0.03

  if car_type == 1 && car_carb == 1
    fp_use = 0.14 * car_km
  elsif car_type == 2 && car_carb == 1
    fp_use = 0.16 * car_km
  elsif car_type == 3 && car_carb == 1
    fp_use = 0.19 * car_km
  elsif car_type == 4 && car_carb == 1
    fp_use = 0.22 * car_km
  elsif car_type == 1 && car_carb == 2
    fp_use = 0.12 * car_km
  elsif car_type == 2 && car_carb == 2
    fp_use = 0.135 * car_km
  elsif car_type == 3 && car_carb == 2
    fp_use = 0.16 * car_km
  elsif car_type == 4 && car_carb == 2
    fp_use = 0.187 * car_km
  elsif car_type == 1 && car_carb == 3
    fp_use = 0.02 * car_km
  elsif car_type == 2 && car_carb == 3
    fp_use = 0.02 * car_km
  elsif car_type == 3 && car_carb == 3
    fp_use = 0.03 * car_km
  elsif car_type == 4 && car_carb == 3
    fp_use = 0.03 * car_km
  else
    p "WRONG INPUT"
    exit
  end




  ## Divide by users

  fp_car = (fp_am_construction + fp_use) / car_users

  puts "Total voiture : #{fp_car} kgC02e"

  total_footprint += fp_car

end

### AUTRES TRANSPORTS

## Scooter/Moto < 250

puts 'Avez-vous un scooter ou une moto ? Quel type ? 1 : Rien, 2 : Scooter ou moto < 250, 3 : Moto > 250, 4 : Les deux'
two_wheels_type = gets.chomp.to_i

fp_two_wheels = 0


if two_wheels_type == 2 || two_wheels_type == 4
  puts "Combien de km parcourez-vous en scooter ou moto < 250 chaque année ?"
  fp_scooter = gets.chomp.to_f * 0.08 # empreinte au km
  fp_two_wheels += fp_scooter
end

## Moto > 250
if two_wheels_type == 3 || two_wheels_type == 4
  puts "Combien de km parcourez-vous en moto > 250 chaque année ?"
  fp_moto = gets.chomp.to_f * 0.19 # empreinte au km
  fp_two_wheels += fp_moto
end

puts "Total 2 roues : #{fp_two_wheels} kgC02e"

total_footprint += fp_two_wheels



## Train

fp_train = 0

train = ""
until train == "Y" || train == "N"
  puts "Prenez-vous le train ? (Y/N)"
  train = gets.chomp.capitalize
end
if train == "Y"
  puts "Combien de trajets courts AR (eq. Nice Cannes) dans l'année ?"
  train_hours_short = gets.chomp.to_i * 1.5 # estimation durée d'un AR dans la catégorie
  puts "Combien de trajets moyens AR (eq. Paris Lyon) dans l'année ?"
  train_hours_middle = gets.chomp.to_i * 4
  puts "Combien de trajets longs AR (eq. Paris Nice) dans l'année ?"
  train_hours_long = gets.chomp.to_i * 12

  const_speed_train_short = 180 # km/h
  const_speed_train_middle = 200 # km/h
  const_speed_train_long = 250 # km/h


  fp_per_km = 0.02

  # calcul pour court/moyen/long : heures * average speed * fp per km

  fp_train = train_hours_short * const_speed_train_short * fp_per_km
  fp_train += train_hours_middle * const_speed_train_middle * fp_per_km
  fp_train += train_hours_long * const_speed_train_long * fp_per_km



end

fp_public_transport = fp_train

## Bus

puts "Combien d'heures passez-vous dans le bus chaque semaine ?"
h_bus = gets.chomp.to_f
fp_bus = h_bus * 1.36 * 52  # empreinte horaire * semaines dans l'année
fp_public_transport += fp_bus

## Metro/tram

puts "Combien d'heures passez-vous dans le métro/tram chaque semaine ?"
h_metro = gets.chomp.to_f
fp_metro = h_metro * 0.08 * 52  # empreinte horaire * semaines dans l'année
fp_public_transport += fp_metro

# unité (heure/km, année/semaine) choisie car semble plus pratique (même choix sur avclim), mais possible d'adapter/standardiser


puts "Total transport en commun : #{fp_public_transport} kgC02e"

total_footprint += fp_public_transport


puts '----------------------------------------'
puts 'JE ME LOGE'
puts '----------------------------------------'

puts "Combien de personnes vivent en moyenne dans votre logement ?"
home_users = gets.chomp.to_f
puts "Quelle est la surface en m2 de votre logement ?"
home_surface = gets.chomp.to_f
puts "Votre logement a t'il plus de 50 ans ? Y/N"
home_old = gets.chomp =="Y"
puts "Quel type de logement ? 1 : Appartement, 2 : Maison, 3 : Maison eco-construite"
home_type = gets.chomp.to_i
puts "Votre logement est-il un logement basse consommation ?"
home_low_cons = gets.chomp
puts "Comment est chauffé votre logement ? 1 : Electricité ou pompe à chaleur, 2 : Gaz, 3 : Fioul, 4 : Bois"
home_heat_type = gets.chomp.to_i
puts "Quel est votre dépense moyenne en électricité par mois ?"
elec_monthly_cost = gets.chomp.to_i
unless home_heat_type == 1
  puts "Quel est votre dépense moyenne en chauffage (gaz, fioul ou bois) par mois ?"
  heat_monthly_cost = gets.chomp.to_i
end


## Amortissement annuel construction

if home_old == "Y" # on considère déjà amorti si > 50 ans
  if home_type == 1
    fp_am_an = home_surface * 10,5 # amortissement annuel moyen par m2 suivant type de logement
  elsif home_type == 2
    fp_am_an = home_surface * 8,5
  elsif home_type == 3
    fp_am_an = home_surface * 2,88
  end
else
  fp_am_an = 0
end

## Conso électrique

# approx conso  —>>> 62,08 kWh ANNUEL par euro de dépense MENSUEL
# multiplié par 0,06 kgCO2e (intensité carbone moyenne par Kwh du mix energetique français)

# pour valeur par défaut, prendre en compte la surface

fp_elec = elec_monthly_cost * 62.08 * 0.06

if home_heat_type == 1 && home_low_cons == 'Y'
  fp_elec_heat_part = fp_elec * 0.24 * 0.3
  fp_elec_other_part = fp_elec * 0.76
  fp_elec = fp_elec_heat_part + fp_elec_other_part
end


## Chauffage

# utilisation du montant dépensé pour plus de facilité, avclim propose aussi de rentrer les données en Kwh
# un barème suivant la surface pourrait faciliter davantage mais pas de données dispo car avclim n'utilise pas ce système

# pour valeur par défaut, prendre en compte la surface

if home_heat_type == 1
  fp_heat = 0 # déjà compté dans elec
elsif home_heat_type == 2
  # gaz approx conso  —>>> 115,08 kWh ANNUEL par euro de dépense MENSUEL
  # multiplié par 0,227 kgCO2e (intensité carbone par Kwh)
  fp_heat = heat_monthly_cost * 115.08 * 0.227
elsif home_heat_type == 3
  # fioul approx conso  —>>> 13,5 litres ANNUEL par euro de dépense MENSUEL
  # multiplié par 3,5 kgCO2e (intensité carbone par litre)
  fp_heat = heat_monthly_cost * 13.5 * 3.5
elsif home_heat_type == 4
  # bois approx conso  —>>> 166,67 kWh ANNUEL par euro de dépense MENSUEL
  # multiplié par 0,03 kgCO2e (intensité carbone par Kwh)
  # on utilise juste bois en granulé et pas en bûches, à voir si on veut séparer ?
  fp_heat = heat_monthly_cost * 166.67 * 0.03
else
  p "WRONG INPUT"
  exit
end

if home_low_cons == "Y"
  fp_heat = fp_heat * 0.3
end


 ## Divide by users

 fp_home = (fp_am_an + fp_elec + fp_heat) / home_users

 puts "Total maison : #{fp_home} kgC02e"

 total_footprint += fp_home



 puts '----------------------------------------'
 puts 'JE MANGE'
 puts '----------------------------------------'

puts "Comment décririez vous votre régime alimentaire ? 1 : Vegan, 2 : Végétarien, 3 : Pescitarien, 4 : Je mange peu de viande, 5 : Alimentation mixte, 6 : Je mange beaucoup de viande"
food_diet = gets.chomp.to_i
#puts "Prenez vous un petit déjeuner ? Y/N"
#food_breakfast = gets.chomp
puts "Consommez-vous de l'eau en bouteille ? Y/N"
food_water = gets.chomp
#puts "Café : combien de tasses par semaine ?"
#food_coffee = gets.chomp.to_f
#puts "Boissons sucrées : combien de litres par semaine ?"
#food_sugar_drinks = gets.chomp.to_f
#puts "Alcool : combien de litres par semaine ?"
#food_alcohol = gets.chomp.to_f
puts "Pour mes déchets, 1 : Je suis zéro déchets, 2 : Je composte, 3 : Je réduis mon gaspillage alimentaire, 4 : Je ne fais rien"
food_waste = gets.chomp.to_i

## Régime alimentaire

# Empreinte repas viande 1 (poulet, porc, fromage) 1.35
# Empreinte repas viande 2 (boeuf, veau, agneau) 6.29
# Empreinte repas poisson 1 (thon, saumon, sardine, maquereau) 1.11
# Empreinte repas poisson 2 (poisson blanc) 1.98
# Empreinte repas végé 0.51
# Empreinte repas vegan 0.39

# choix de personas, autre choix possible : sliders qui add to 100 sur % de repas du type

# PERSONAS

# je suis vegan
# 100% repas vegan (base 2 repas par jour)
# 0.39 * 730
# = 284,7 kg CO2e / an

# je suis végétarien
# 80% repas végé, 20% repas vegan
# 0.39 * 146 + 0.51 * 584
# = 354,8 kg CO2e / an

# je suis pescetarien
# 20% repas poisson 1, 20% repas poisson 2, 40% repas végé, 20% repas vegan
# 1.11 * 146 + 1.98 * 146 + 0.51 * 292 + 0.39 * 146
# = 657 kg CO2e / an

# je mange peu de viande
# 10% viande 1, 10% viande 2, 15% poisson 1, 15% poisson 2, 30% végé, 20% vegan
# 73 * 1.35 + 73 * 6.29 + 109.5 * 1.11 + 109.5 * 1.98 + 219 * 0.51  + 146 * 0.39
# = 1064.7 kg CO2e / an

# j’ai une alimentation mixte
# 20% viande 1, 20% viande 2, 20% poisson 1, 20% poisson 2, 20% végé
# 146 * 1.35 + 146 * 6.29 + 146 * 1.11 + 146 * 1.98 + 146 * 0.51
# = 1641.04 kg CO2e / an

# je mange très souvent de la viande
# 40% viande 1, 40% viande 2, 10% poisson 1, 10% poisson 2
# 292 * 1.35 + 292 * 6.29 + 73 * 1.11 + 73 * 1.98
# = 2456.45 kg CO2e / an

if food_diet == 1
  fp_food_total = 284.7
elsif food_diet == 2
  fp_food_total = 354.8
elsif food_diet == 3
  fp_food_total = 657
elsif food_diet == 4
  fp_food_total = 1064.7
elsif food_diet == 5
  fp_food_total = 1641.04
elsif food_diet == 6
  fp_food_total = 2456.45
else
  p "WRONG INPUT"
  exit
end

## Breakfast

# choix de pas détailler, moyenne à 0.3 kg CO2e par jour * 365

# if food_breakfast == 'Y'
#   fp_food_total += 109.5
# end

## water
if food_water == "Y"
  total_footprint += food_water
end



## Café, boissons sucrées, alcool > recup de valeurs moyennes de avclim
#fp_food_total += (food_coffee * 0.11 * 52)
#fp_food_total += (food_sugar_drinks * 0.49 * 52)
#fp_food_total += (food_alcohol * 1.06 * 52)


##  déchets

if food_waste == 1
  fp_food_total += 48
elsif food_waste == 2
  fp_food_total += 183
elsif food_waste == 3
  fp_food_total += 164
elsif food_waste == 2
  fp_food_total += 194
end


total_footprint += fp_food_total

puts "Total food : #{fp_food_total} kgC02e"


puts '----------------------------------------'
puts "J'ACHETE"
puts '----------------------------------------'

## Personas à la louche sur plusieurs simulations avclim, affinable

puts "Avez-vous beaucoup d'appareils numériques de moins de 10 ans ? 1 : Beaucoup , 2 : Moyennement, 3 : Peu"
buy_num = gets.chomp.to_i
puts "Avez-vous beaucoup d'électroménager de moins de 10 ans ? 1 : Beaucoup , 2 : Moyennement, 3 : Peu"
buy_elec = gets.chomp.to_i
puts "Achetez-vous souvent des vêtements neufs ? 1 : Très souvent, 2 : Régulièrement, 3 : Occasionnellement, 4 : Rarement"
buy_clothes = gets.chomp.to_i


if buy_num == 1
  fp_num = 500
elsif buy_num == 2
  fp_num = 220
elsif buy_num == 3
  fp_num = 90
else
  puts "WRONG INPUT"
  exit
end


if buy_elec == 1
  fp_elec = 350 / home_users
elsif buy_elec == 2
  fp_elec = 130 / home_users
elsif buy_elec == 3
  fp_elec = 50 / home_users
else
  puts "WRONG INPUT"
  exit
end


if buy_clothes == 1
  fp_clothes = 550
elsif buy_clothes == 2
  fp_clothes = 386
elsif buy_clothes == 3
  fp_clothes = 223
elsif buy_clothes == 4
  fp_clothes = 60
else
  puts "WRONG INPUT"
  exit
end

fp_buy_total = fp_num + fp_elec + fp_clothes


puts "Total achats : #{fp_buy_total} kgC02e"


total_footprint += fp_buy_total


puts '----------------------------------------'
puts "Constante services publics : 1113 kgC02e"
total_footprint += 1113

puts '----------------------------------------'
puts "Votre empreinte carbone annuelle est de #{(total_footprint.to_f/1000).round(2)} tCO2e."
puts "Cela représente la consommation en carburant de #{(total_footprint/78).to_i} minutes de vol du jet privé de Vincent Bolloré, ou de #{(total_footprint/233).to_i} kilomètres parcourus par le yacht de Bernard Arnault."

# On peut inverser jet/yacht de Arnault/Bolloré mais le yacht de Arnault est beaucoup plus gros et consomme environ 6.5 fois plus au km (leurs jets sont équivalents)
