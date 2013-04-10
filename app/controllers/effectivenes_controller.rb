class EffectivenesController < ApplicationController
   filter_access_to :all
layout 'worker'

  def index
  @effectivenes = Effectivenes.order(:id)
  respond_to do |format|
    format.html
    format.csv { send_data @effectivenes.to_csv }
    format.xls # { send_data @effectivenes.to_csv(col_sep: "\t") }
      #send_data   
    end
  end
  def calendar
  	 @effectivenes = Effectivenes.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  	@workers = Worker.includes(:effectivenes).all
  end

  
def new
  @nowa_efektywnosc =  Effectivenes.new
end

def create 
    @worker = Worker.find(params[:effectivenes][:worker_id])
    @nowa_efektywnosc =  Effectivenes.new(params[:effectivenes])
    if @nowa_efektywnosc.save 
      flash[:notice] = "Poprawnie dodano efektywnosc"
      redirect_to szczegoly_po_id_path(@worker.id)
    else
      flash[:notice] = "Nie udalo sie dodac celu sprawdz poprawnosc wypelnionych pol."
      redirect_to szczegoly_po_id_path(@worker.id)

  end
end
def javascript
  
end


end
