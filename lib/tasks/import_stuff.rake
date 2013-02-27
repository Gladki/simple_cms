namespace :csv do

  desc "Import CSV Data"
  task :import_stuff => :environment do

    require 'csv'

    csv_file_path = 'db/data.csv'

    CSV.foreach(csv_file_path) do |row|
      row = Model.create!({
        :column1 => row[0],
        :column2 => row[1],
        :column3 => row[2],        
      })
      puts "Row added!"
    end
  end
end