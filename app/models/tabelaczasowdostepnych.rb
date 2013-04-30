class Tabelaczasowdostepnych < ActiveRecord::Base

 self.table_name = 'tabela_czasow_dostepnych'
 validates_presence_of [:tcd_id_worker, 
                 :tcd_id_worker_merx, 
                 :tcd_data, 
                 :tcd_sum_godz_przep,
                 :tcd_sum_godz_chor], :on => :create


 attr_accessible :tcd_id_worker, 
                 :tcd_id_worker_merx, 
                 :tcd_data, 
                 :tcd_sum_godz_przep, 
                 :tcd_sum_godz_chor, 
            
                 :tcd_import_file_info,
                 :tcd_aud_us_id


def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Nieznany typ pliku: #{file.original_filename}"
  end
end
  def self.import(file)
  tcd_import_file_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Tabelaczasowdostepnych.all(:select => "tcd_import_file_info").to_a.to_s.include?(tcd_import_file_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'CZAS_DOST'
      header = ['tcd_id_worker','tcd_id_worker_merx','tcd_data','tcd_sum_godz_przep','tcd_sum_godz_chor','tcd_import_file_info']
      (1..ex.last_row).each do |i|

      tcd_id_worker = ex.cell(i,'A')
      tcd_id_worker_merx = ex.cell(i,'B')
      tcd_data = ex.cell(i,'C')
      tcd_sum_godz_przep = ex.cell(i,'D')
      tcd_sum_godz_chor = ex.cell(i,'E')
     
      row = Hash[[header,[tcd_id_worker,tcd_id_worker_merx,tcd_data,tcd_sum_godz_przep,tcd_sum_godz_chor,tcd_import_file_info]].transpose]
      Tabelaczasowdostepnych.create row 
    end
  end
end



end            