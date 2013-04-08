class Tabelanormatywow < ActiveRecord::Base

self.table_name = 'tabela_normatywow'
 validates_presence_of [:tn_kod_czynnosci, 
                 :tn_obszar, 
                 :tn_opis_czynnosci, 
                 :tn_jednostka_odniesienia, 
                 :tn_czas,
                 :tn_import_file_info], :on => :create


 attr_accessible :tn_id, 
                 :tn_kod_czynnosci, 
                 :tn_obszar, 
                 :tn_opis_czynnosci, 
                 :tn_opis_czynnosci_szczegolowy, 
                 :tn_jednostka_odniesienia, 
                 :tn_czas,
                 :tn_komentarz,
                 :tn_import_file_info,
                 :tn_aud_us_id
    
 def self.to_csv (options = {})
   CSV.generate(options) do |csv|
     csv << column_names
     all.each do |tn|
       csv << tn.attributes.values_at(*column_names)
     end
   end
  
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
  tn_import_file_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Tabelanormatywow.all(:select => "tn_import_file_info").to_a.to_s.include?(tn_import_file_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'NORMATYWY_CZAS'
      header = ['tn_kod_czynnosci','tn_obszar','tn_opis_czynnosci','tn_opis_czynnosci_szczegolowy','tn_jednostka_odniesienia','tn_czas','tn_komentarz','tn_import_file_info']
      (3..ex.last_row).each do |i|

      tn_kod_czynnosci = ex.cell(i,'A')
      tn_obszar = ex.cell(i,'B')
      tn_opis_czynnosci = ex.cell(i,'C')
      tn_opis_czynnosci_szczegolowy = ex.cell(i,'D')
      tn_jednostka_odniesienia = ex.cell(i,'E')
      tn_czas = ex.cell(i,'F')
      tn_komentarz = ex.cell(i,'H')
      row = Hash[[header,[tn_kod_czynnosci,tn_obszar,tn_opis_czynnosci,tn_opis_czynnosci_szczegolowy,tn_jednostka_odniesienia,tn_czas,tn_komentarz,tn_import_file_info]].transpose]
      Tabelanormatywow.create row 
    end
  end
end


end
