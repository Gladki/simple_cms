class CelesController < ApplicationController

    filter_access_to :all


before_filter :find_worker , :only => [:create]
before_filter :cel_id , :only => [:delete]

def find_worker
     @worker = Worker.find(params[:cele][:ce_worker_id])
    
end
def cel_id
    @cel = Cele.find(params[:id2])

end

def new
	@nowy_cel =  Cele.new
end

def create 
    @nowy_cel =  Cele.new(params[:cele])
    if @nowy_cel.save 
    	flash[:notice] = "Poprawnie dodano cel"
    	redirect_to szczegoly_po_id_path(@worker.id)
    else
    	flash[:notice] = "Nie udalo sie dodac celu sprawdz poprawnosc wypelnionych pol."
    	redirect_to szczegoly_po_id_path(@worker.id)

	end
end
def delete

    if @cel.destroy
    flash[:notice] = "Poprawnie usunieto cel."
        redirect_to szczegoly_po_id_path(params[:id])
    else
    flash[:notice] = "Nie udalo sie usunac celu."
        redirect_to szczegoly_po_id_path(params[:id])
    end
  end

end
