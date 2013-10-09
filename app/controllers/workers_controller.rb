class WorkersController < ApplicationController

 filter_access_to :all
 before_filter :worker_by_id , :only => [:edit, :update, :delete, :szczegoly]
 before_filter :workers_all , :only => [:lista,:index]
  

 layout 'worker'
 


 def worker_by_id
    @worker = Worker.find(params[:id])
 end

 def workers_all 
    @workers = Worker.includes(:effectivenes).all
 end   
 
  def index
    
  end
  def lista
    @new_worker = Worker.new
    @workers_by_order = Worker.order(:id)
    respond_to do |format|
    format.html
    format.csv { send_data @workers_by_order.to_csv ,:filename => 'lista-pracownikow-' + DateTime.now.to_date.strftime("%d-%m-%Y") }
    format.xls 
    end
  end

  def new 
    @new_worker = Worker.new
  end
  def create 
  
    @new_worker = Worker.new(params[:worker]) 
   if @new_worker.save 
      flash[:notice] = "Poprawnie dodano pracownika!"
        redirect_to :action => "lista"
    else
      render :action => "lista"
        flash[:notice] = "Nie udalo sie dodac pracownika sprawdz poprawnosc pol!"
    end

  end
  def calendar
    @realizacjanorm = Realizacjanorm.select("rn_data, rn_id_worker_merx, sum(rn_normatywy_czas_suma_tj) as suma").group("rn_data, rn_id_worker_merx") #.order("rn_data desc")
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @workers = Worker.all
  end
  def delete
    if @worker.destroy
      redirect_to :action => "lista" 
      flash[:notice] = "Poprawnie usunieto pracownika z bazy"
    else
      redirect_to :action => "lista" 
      flash[:notice] = "Nie udalo sie usunac pracownika"
    end
  end 
 

  def pracownik
  end

  def szczegoly

    @effec = Effectivenes.find(:all, :conditions => ["worker_id = ?" , @worker.id], :order => "id DESC")
    @rn = Realizacjanorm.find(:all, :conditions => ["rn_id_worker = ? or rn_id_worker_merx = ?" , @worker.id, @worker.id_worker_merx], :order => "rn_data DESC")
    @worker_count = Worker.count
    @cele = Cele.find(:all,:conditions => ["ce_worker_id = ?" , @worker.id], :order => "created_at DESC")
    @premie = Premie.find(:all,:conditions => ["pe_worker_id = ?" , @worker.id], :order => "id DESC")
    @nowy_cel = Cele.new
    @nowa_efektywnosc = Effectivenes.new
    @nowa_premia = Premie.new
  end

  def import_render
    render ('import')
  end

  def import
    Effectivenes.import(params[:file])
    redirect_to import_danych_path, notice: "Efektywnosci dodane"
  end

  def import_tn
    Tabelanormatywow.import(params[:file])
    if Tabelanormatywow.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela Normatywow zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end

  def import_workers
    Worker.import(params[:file])
    if Worker.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela pracownikow zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end

  def import_tc
    Typyczynnosci.import(params[:file])
    if Typyczynnosci.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela Czynnosci zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end
  def import_tt
    Tabelatransportowa.import(params[:file])
    if Tabelatransportowa.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela Transportowa zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end
  def import_tdc
    Tabelaczasowdostepnych.import(params[:file])
    if Tabelaczasowdostepnych.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela czasow dostepnych zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end
 def import_rn
    Realizacjanorm.import(params[:file])
    if Realizacjanorm.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela realizacji norm dostepnych zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end 
  def import_rn_finall
    Realizacjanorm.import_finall(params[:file])
    if Realizacjanorm.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela realizacji norm dostepnych zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end
   def import_stanowiska
    Position.import(params[:file])
    if Position.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela stanowisk zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end
  def import_jednostki_organizacyjne
    Jednostkaorganizacyjna.import(params[:file])
    if Jednostkaorganizacyjna.create.new_record? == true  
      redirect_to import_danych_path, notice: "Tabela stanowisk zostala poprawnie dodana"
    else
      redirect_to import_danych_path, notice: "Plik o podanej nazwie zostal juz poprawnie wgrany!"
    end
  end


end