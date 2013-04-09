class Effectivenes < ActiveRecord::Base

 belongs_to :worker
 attr_accessible :effectivity, :effectivity_max, :effectivity_min, :id, :worker_id, :created_at
 
 def self.to_csv (options = {})
   CSV.generate(options) do |csv|
     csv << column_names
     all.each do |effectivity|
       csv << effectivity.attributes.values_at(*column_names)
     end
   end
  
 end

def self.effectivity_on(date,id)
    find(:all, :conditions => ["date(created_at) = ? and worker_id = ?" ,date,id])
  end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Nieznany typ pliku: #{file.original_filename}"
  end
end
  def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    Effectivenes.create row
  end
end


end
