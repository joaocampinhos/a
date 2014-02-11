require 'csv'


namespace :csv do
  desc "Import csv data"
  task import_earthquakes: :environment do
    file_path = "db/data/earthquakes.csv"
    import_csv_data("earthquakes", "Terremotos", file_path)
  end
  task import_accidents: :environment do
    file_path = "db/data/accidents.csv"
    import_csv_data("accidents", "Acidentes UK", file_path)
  end
  task import_fires: :environment do
    file_path = "db/data/fires.csv"
    import_csv_data("fires", "Incêndios PT", file_path)
  end
  task import_all: [:import_earthquakes, :import_fires, :import_accidents]
end


def import_csv_data(dataset_name, dataset_label, file_path)
  dataset = Dataset.create(name: dataset_name, label: dataset_label)
  dataset.create_table
  points = []
  CSV.foreach(file_path, headers: true) do |row|
    record = row.to_hash
    hash = {latitude: row[0], longitude: row[1]}
    dataset.insert_tuple(hash)
  end
  #kd = Kdtree.new(points)
  #File.open("#{file_path}.tree", "w") {|f| kd.persist(f)}
end