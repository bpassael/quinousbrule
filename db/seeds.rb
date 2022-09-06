# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Measurement.destroy_all



m1 = Measurement.new(
  title: "🚙 Je remplace ma voiture par une voiture électrique",
  kgCO2e_year: 345.7,
  eq_minutes_flight_jet_bollore: 4.43,
  eq_km_yacht_arnault: 1.50,
  additional_info: "Achetée neuve",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m1.save!


m2 = Measurement.new(
  title: "🔥 J'installe une pompe à chaleur",
  kgCO2e_year: 1477.88,
  eq_minutes_flight_jet_bollore: 18.95,
  eq_km_yacht_arnault: 6.43,
  additional_info: "À la place d'une chaudière gaz",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m2.save!


m3 = Measurement.new(
  title: "🥑 Je deviens végan",
  kgCO2e_year: 1180.14,
  eq_minutes_flight_jet_bollore: 15.13,
  eq_km_yacht_arnault: 5.13,
  additional_info: "À partir d'une alimentation mixte",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m3.save!


m4 = Measurement.new(
  title: "🍳 Je deviens végétarien",
  kgCO2e_year: 1095.69,
  eq_minutes_flight_jet_bollore: 14.05,
  eq_km_yacht_arnault: 4.76,
  additional_info: "À partir d'une alimentation mixte",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m4.save!


m4 = Measurement.new(
  title: "🐓 Je privilégie la volaille ou le porc à la viande rouge",
  kgCO2e_year: 828.52,
  eq_minutes_flight_jet_bollore: 10.62,
  eq_km_yacht_arnault: 3.60,
  additional_info: "Sur la base d'une alimentation mixte",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m4.save!


m5 = Measurement.new(
  title: "🐄 Je mange de la viande rouge uniquement le week-end",
  kgCO2e_year: 807.03,
  eq_minutes_flight_jet_bollore: 10.35,
  eq_km_yacht_arnault: 3.51,
  additional_info: "Sur la base d'une alimentation mixte",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m5.save!


m6 = Measurement.new(
  title: "🛬 J'arrête de prendre l'avion (voyageur occasionnel)",
  kgCO2e_year: 3200,
  eq_minutes_flight_jet_bollore: 41.03,
  eq_km_yacht_arnault: 13.91,
  additional_info: "Sur une base de 2 vols domestique, 1 vol moyen courrier et 1 vol long courrier dans l'année",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m6.save!


m7 = Measurement.new(
  title: "✈️ J'arrête de prendre l'avion (voyageur régulier)",
  kgCO2e_year: 6500,
  eq_minutes_flight_jet_bollore: 83.33,
  eq_km_yacht_arnault: 28.26,
  additional_info: "Sur une base 4 vols domestiques, 2 vols moyen courrier et 2 vols long courrier dans l'année",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m7.save!



m8 = Measurement.new(
  title: "💻 Je fais du 100% télétravail",
  kgCO2e_year: 761.40,
  eq_minutes_flight_jet_bollore: 9.76,
  eq_km_yacht_arnault: 3.31,
  additional_info: "Sur la base d'un trajet domicile / travail en voiture de 10 kilomètres, 5 jours dans la semaine",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m8.save!

m9 = Measurement.new(
  title: "🚅 Je privilégie le train à l'avion",
  kgCO2e_year: 1192,
  eq_minutes_flight_jet_bollore: 15.28,
  eq_km_yacht_arnault: 5.18,
  additional_info: "Sur la base de 4 A/R Paris/Marseille dans l'année",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m9.save!


m10 = Measurement.new(
  title: "🚲 Je prends le vélo plutôt que la voiture pour les trajets courts",
  kgCO2e_year: 491.40,
  eq_minutes_flight_jet_bollore: 6.30,
  eq_km_yacht_arnault: 2.14,
  additional_info: "Sur la base de 14 trajets par semaine",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m10.save!


m11 = Measurement.new(
  title: "⛄️ Je réduis la température de mon chauffage de 1°",
  kgCO2e_year: 100.54,
  eq_minutes_flight_jet_bollore: 1.29,
  eq_km_yacht_arnault: 0.44,
  additional_info: "Sur la base d'un chauffage au fioul ou au gaz",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m11.save!


m12 = Measurement.new(
  title: "🔌 J'éteins mes appareils en veille lorsque je ne suis pas chez moi",
  kgCO2e_year: 6.56,
  eq_minutes_flight_jet_bollore: 0.08,
  eq_km_yacht_arnault: 0.03,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m12.save!


m13 = Measurement.new(
  title: "🚘 J'adopte l'eco-conduite",
  kgCO2e_year: 247.05,
  eq_minutes_flight_jet_bollore: 3.17,
  eq_km_yacht_arnault: 1.07,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m13.save!



m14 = Measurement.new(
  title: "🎢 Je reduis ma vitesse de 130 à 110 km/heure",
  kgCO2e_year: 101.25,
  eq_minutes_flight_jet_bollore: 1.30,
  eq_km_yacht_arnault: 0.45,
  additional_info: "Sur la base de 3000 kilomètres d'autoroute parcourus dans l'année",
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m14.save!


m15 = Measurement.new(
  title: "🍽 Je réduis le gaspillage alimentaire",
  kgCO2e_year: 30,
  eq_minutes_flight_jet_bollore: 0.38,
  eq_km_yacht_arnault: 0.13,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m15.save!


m16 = Measurement.new(
  title: "🕰 Je fais durer mon électroménager",
  kgCO2e_year: 21.09,
  eq_minutes_flight_jet_bollore: 0.27,
  eq_km_yacht_arnault: 0.09,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m16.save!


m17 = Measurement.new(
  title: "🗑 Je composte",
  kgCO2e_year: 11.01,
  eq_minutes_flight_jet_bollore: 0.14,
  eq_km_yacht_arnault: 0.05,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m17.save!


m18 = Measurement.new(
  title: "📬 Je mets un stop pub sur ma boîte aux lettres",
  kgCO2e_year: 12.95,
  eq_minutes_flight_jet_bollore: 0.17,
  eq_km_yacht_arnault: 0.06,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m18.save!


m19 = Measurement.new(
  title: "💡 Je remplace les ampoules par des LEDs",
  kgCO2e_year: 7.08,
  eq_minutes_flight_jet_bollore: 0.09,
  eq_km_yacht_arnault: 0.03,
  source_link: "nosgestesclimat.fr",
  source_name: "ADEME"
)

m19.save!
