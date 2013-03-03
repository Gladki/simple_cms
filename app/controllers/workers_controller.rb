class WorkersController < ApplicationController
require 'iconv'

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