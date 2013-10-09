class Obszar < ActiveRecord::Base

	# belongs_to :worker
	self.table_name = 'obszary'
	
	 validates_presence_of [:ob_nazwa,:ob_opis], :on => :create
	attr_accessible :id, 
	             :ob_nazwa, 
	             :ob_magazyn,
	             :ob_opis,
	             :ob_kod,
	             :ob_wartosc,
	             :ob_aud_us_id
def pelna_nazwa_obszaru
	"#{ob_kod} - #{ob_nazwa}"
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
  w_import_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Obszar.all(:select => "w_import_info").to_a.to_s.include?(w_import_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'STANOWISKA'
      header = ['name','w_import_info']
      (2..ex.last_row).each do |i|

      name = ex.cell(i,'B')
    
      row = Hash[[header,[name,w_import_info]].transpose]
      Obszar.create row 
    end
  end
end


end
