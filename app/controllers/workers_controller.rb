class WorkersController < ApplicationController
 

 before_filter :worker_by_id , :only => [:edit, :update, :delete, :szczegoly]
 before_filter :workers_all , :only => [:lista]


 layout 'worker'
 
 require 'csv'

 def worker_by_id
    @worker = Worker.find(params[:id])
 end

 def workers_all 
    @workers = Worker.all
 end   
 
  def index
    render('lista')
    @pracownik = Worker.find(params[:id])
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
    @new_position = Position.new
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
    @effec = Effectivenes.find(:all, :conditions => ["worker_id = ?" , @worker.id])
    @worker_count = Worker.count
    @efektyw = @worker.effectivenes
  end

  def import_render
    render ('import')
  end

  def import
    Effectivenes.import(params[:file])
    redirect_to root_url, notice: "Efektywnosci dodane"
  end

end