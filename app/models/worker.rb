class Worker < ActiveRecord::Base
 attr_accessible :id_worker,:id_worker_hr, :id_worker_merx, :jednostka_organizacyjna,:last_name, :first_name,:obszar,:profil_merx,:przelozony,:position_ids,:przelozony_przelozonego, :stanowisko, :w_import_info
 belongs_to :search
 has_many :effectivenes, :class_name => "Effectivenes"
 has_many :cele, :class_name => "Cele"
 has_many :realizacjanorm, :class_name => "Realizacjanorm"


 has_and_belongs_to_many :positions

 # validates_presence_of [:id_worker_hr,:id_worker_merx,:last_name,:first_name], :on => :create
 # validates_numericality_of [:id_worker_hr,:id_worker_merx], :only_integer => true, :on => :create
	


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
  if Worker.all(:select => "w_import_info").to_a.to_s.include?(w_import_info) == false
      ex = open_spreadsheet(file)
      ex.default_sheet = 'PRACOWNICY'
      header = ['id_worker_hr','id_worker_merx','jednostka_organizacyjna','last_name','first_name','obszar','profil_merx','stanowisko','przelozony','przelozony_przelozonego','w_import_info']
      (2..ex.last_row).each do |i|

      id_worker_hr = ex.cell(i,'A')
      id_worker_merx = ex.cell(i,'B')
      jednostka_organizacyjna = ex.cell(i,'C')
      last_name = ex.cell(i,'D')
      first_name = ex.cell(i,'E')
      obszar = ex.cell(i,'F')
      profil_merx = ex.cell(i,'G')
      stanowisko = ex.cell(i,'H')
      przelozony = ex.cell(i,'I')
      przelozony_przelozonego = ex.cell(i,'J')
      row = Hash[[header,[id_worker_hr,id_worker_merx,jednostka_organizacyjna,last_name,first_name,obszar,profil_merx,stanowisko,przelozony,przelozony_przelozonego,w_import_info]].transpose]
      Worker.create row 
    end
  end
end

	




	def self.to_csv (options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |workers|
				csv << workers.attributes.values_at(*column_names)
			end
		end
	end



	def self.search(search)
	  if search
	    find(:all, :conditions => ['id in (?)', search])
	  else
	    find(:all)
	  end
	end


end
