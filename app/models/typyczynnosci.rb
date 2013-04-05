class Typyczynnosci < ActiveRecord::Base

self.table_name = 'typy_czynnosci'
 validates_presence_of [:tc_kod,:tc_opis,:tc_zrodlo_pochodzenia], :on => :create


 attr_accessible :id, 
                 :tc_kod, 
                 :tc_opis,
                 :tc_zrodlo_pochodzenia


def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Nieznany typ pliku: #{file.original_filename}"
  end
end

def self.import(file)
      tc_import_file_info = File.basename(file.original_filename, File.extname(file.original_filename))
  
      ex = open_spreadsheet(file)
      ex.default_sheet = 'TYPY_CZYNNOSCI'
      header = ['tc_kod','tc_opis','tc_zrodlo_pochodzenia']
      (2..ex.last_row).each do |i|

      tc_kod = ex.cell(i,'A')
      tc_opis = ex.cell(i,'B')
     
      row = Hash[[header,[tc_kod,tc_opis,tc_import_file_info]].transpose]
      Typyczynnosci.create row 
    end
  end

end

