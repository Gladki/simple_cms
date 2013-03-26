class WorkersController < ApplicationController
  # filter_resource_access
# require 'iconv'

 require 'csv'

  layout 'worker'
  @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
  def index
    render('lista')
    @pracownik = Worker.find(params[:id])
  end
  def lista
    @workers = Worker.all


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

    end

  end

  def delete
    if Worker.find(params[:id]).destroy
      flash[:notice] = "Poprawnie usunieto pracownika z bazy"
      redirect_to :action => "lista"
    else
      flash[:notice] = "Nie udalo sie usunac pracownika"
      redirect_to :action => "lista"
    end
  end


  def pracownik
  @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
  end


  def szczegoly
    @workers = Worker.find(:all, :include => [:effectivenes], :joins => [:effectivenes])
    @worker = Worker.find(params[:id])
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

  def javascript

  end
end