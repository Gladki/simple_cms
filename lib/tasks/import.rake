require 'csv'

desc "Import teams from csv file"
task :import => [:environment] do

  file = "db/data2.csv"

  CSV.foreach(file, :headers => true) do |row|
    Worker.create(
		:id_worker => row[0],  
		:id_worker_merx => row[1],  
		:last_name => row[2],  
		:first_name => row[3]
    )

  end
puts "Import zakonczony"
end