class WorkersController < ApplicationController

 filter_access_to :all
 before_filter :worker_by_id , :only => [:edit, :update, :delete, :szczegoly]
 before_filter :workers_all , :only => [:lista,:index]
  

 layout 'worker'
 
 require 'csv'

 def worker_by_id
    @worker = Worker.find(params[:id])
 end

 def workers_all 
    @workers = Worker.includes(:effectivenes).all
 end   
 
  def index
    
  end
  def lista
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
      flash[:notice] = "Poprawnie dodano pracownika"
        redirect_to :action => "new"
    else
      render :action => "new"
        flash[:notice] = "Nie udalo sie dodac pracownika sprawdz poprawnosc pol"
    end

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
    @worker_count = Worker.count
    @cele = Cele.find(:all,:conditions => ["ce_worker_id = ?" , @worker.id], :order => "id DESC")
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


end