class Jednostkaorganizacyjna < ActiveRecord::Base

 attr_accessible :id, :name, :created_at , :updated_at, :w_import_info
 has_and_belongs_to_many :workers
 
 
 self.table_name = 'jednostka_organizacyjna'
def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Nieznany typ pliku: #{file.original_filename}"
  end
end
  def self.import(file)
  w_import_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Jednostkaorganizacyjna.all(:select => "w_import_info").to_a.to_s.include?(w_import_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'JEDNOSTKA ORGANIZACYJNA'
      header = ['name','w_import_info']
      (2..ex.last_row).each do |i|

      name = ex.cell(i,'B')
    
      row = Hash[[header,[name,w_import_info]].transpose]
      Jednostkaorganizacyjna.create row 
    end
  end
end

	

end
