class Realizacjanorm < ActiveRecord::Base
 belongs_to :worker

 self.table_name = 'realizacja_norm'
 validates_presence_of [:rn_id_worker_merx, 
                 :rn_data, 
                 :rn_magazyn, 
                 :rn_obszar,:rn_normatywy_czas_suma_tg,:rn_normatywy_czas_suma_tj], :on => :create


 attr_accessible :rn_id_worker,
                 :rn_id_worker_hr,
                 :rn_id_worker_merx,
                 :rn_data,
    
                 :rn_obszar,
                 :rn_magazyn,
                 :rn_typ_operacji,
                 :rn_komentarz,

                 :rn_normatywy_czas_suma_tg,
                 :rn_normatywy_czas_suma_tj,
                
                 :rn_import_file_info,
                 :rn_aud_us_id
    
 



def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Nieznany typ pliku: #{file.original_filename}"
  end
end
  def self.import(file)
  rn_import_file_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Realizacjanorm.all(:select => "rn_import_file_info").to_a.to_s.include?(rn_import_file_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'REALIZACJA_NORM'
      header = ['rn_id_worker','rn_id_worker_hr','rn_id_worker_merx','rn_data','rn_obszar',
                'rn_magazyn','rn_typ_operacji','rn_komentarz',
                'rn_normatywy_czas_suma_tg','rn_normatywy_czas_suma_tj',
                'rn_import_file_info']
      (4..ex.last_row).each do |i|

      rn_id_worker = ex.cell(i,'A')
      rn_id_worker_hr = ex.cell(i,'B')
      rn_id_worker_merx = ex.cell(i,'C')
      rn_data = ex.cell(i,'D')
      rn_obszar = ex.cell(i,'E')
      rn_magazyn = ex.cell(i,'F')
      rn_typ_operacji = ex.cell(i,'G')
      rn_komentarz = ex.cell(i,'H')
      rn_normatywy_czas_suma_tg = ex.cell(i,'I')
      rn_normatywy_czas_suma_tj = ex.cell(i,'J')
   

      row = Hash[[header,[rn_id_worker,rn_id_worker_hr,rn_id_worker_merx,rn_data,rn_obszar,
                          rn_magazyn,rn_typ_operacji, rn_komentarz,
                          rn_normatywy_czas_suma_tg, rn_normatywy_czas_suma_tj, 
                          rn_import_file_info]].transpose]
      Realizacjanorm.create row 
    end
  end
end


end
