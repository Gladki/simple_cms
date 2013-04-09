class Tabelatransportowa < ActiveRecord::Base

self.table_name = 'tabela_transportowa'
 # validates_presence_of [:tn_kod_czynnosci, 
 #                 :tn_obszar, 
 #                 :tn_opis_czynnosci, 
 #                 :tn_jednostka_odniesienia, 
 #                 :tn_czas,
 #                 :tn_import_file_info], :on => :create

has_one :dodatek
has_one :predkosc
 attr_accessible :tt_id, 
                  :tt_nr_drogi,
                  :tt_nr_drogi_system,
                  :tt_przebieg_trasy,
                  :tt_opis_trasy,
                  :tt_typ_operacji,
                  :tt_obszar,
                  :tt_ruch_od,
                  :tt_ruch_do,
                  :tt_srodek_transportu,
                  :tt_dystans_od,
                  :tt_dystans_do,
                  :tt_ilosc_zakretow,
                  :tt_ilosc_start_stop,
                  :tt_rodzaj_pobrania,
                  :tt_komentarz,
                  :tt_predkosc_kod,
                  :tt_dodatek_kod,
                  :tt_import_file_info,
                  :tt_aud_us_id
    
 def self.to_csv (options = {})
   CSV.generate(options) do |csv|
     csv << column_names
     all.each do |tt|
       csv << tt.attributes.values_at(*column_names)
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
  tt_import_file_info = File.basename(file.original_filename, File.extname(file.original_filename))
  if Tabelatransportowa.all(:select => "tt_import_file_info").to_a.to_s.include?(tt_import_file_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'TABELA_TRANSPORTOWA'
      header = ['tt_nr_drogi',
                'tt_nr_drogi_system',
                'tt_przebieg_trasy',
                'tt_opis_trasy',
                'tt_typ_operacji',
                'tt_obszar',
                'tt_ruch_od',
                'tt_ruch_do',
                'tt_srodek_transportu',
                'tt_dystans_od',
                'tt_dystans_do',
                'tt_ilosc_zakretow',
                'tt_ilosc_start_stop',
                'tt_rodzaj_pobrania',
                'tt_komentarz',
                'tt_predkosc_kod',
                'tt_dodatek_kod',
                'tt_import_file_info']
      (5..ex.last_row).each do |i|

      tt_nr_drogi = ex.cell(i,'A')
      tt_nr_drogi_system = ex.cell(i,'B')
      tt_przebieg_trasy = ex.cell(i,'C')
      tt_opis_trasy = ex.cell(i,'D')
      tt_typ_operacji = ex.cell(i,'E')
      tt_obszar = ex.cell(i,'F')
      tt_ruch_od = ex.cell(i,'G')
      tt_ruch_do = ex.cell(i,'H')
      tt_srodek_transportu = ex.cell(i,'I')
      tt_dystans_od = ex.cell(i,'J')
      tt_dystans_do = ex.cell(i,'K')
      tt_ilosc_zakretow = ex.cell(i,'L')
      tt_ilosc_start_stop = ex.cell(i,'M')
      tt_rodzaj_pobrania = ex.cell(i,'N')
      tt_komentarz = ex.cell(i,'O')
      tt_predkosc_kod = ex.cell(i,'P')
      tt_dodatek_kod = ex.cell(i,'Q')
      row = Hash[[header,[tt_nr_drogi,
                          tt_nr_drogi_system,
                          tt_przebieg_trasy,
                          tt_opis_trasy,
                          tt_typ_operacji,
                          tt_obszar,
                          tt_ruch_od,
                          tt_ruch_do,
                          tt_srodek_transportu,
                          tt_dystans_od,
                          tt_dystans_do,
                          tt_ilosc_zakretow,
                          tt_ilosc_start_stop,
                          tt_rodzaj_pobrania,
                          tt_komentarz,
                          tt_predkosc_kod,
                          tt_dodatek_kod,
                          tt_import_file_info]].transpose]
      Tabelatransportowa.create row 
    end
  end
end


end
