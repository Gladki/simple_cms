require 'csv'

desc "Import teams from csv file"
task :import_effectivity => [:environment] do

  file = "db/effectivity.csv"

  CSV.foreach(file, :headers => true) do |row|
    Effectivenes.create(
    :worker_id => row[0],  
    :effectivity => row[1],  
    :effectivity_min => row[2],  
    :effectivity_max => row[3]
    )

       
  end
puts "Import zakonczony"
end