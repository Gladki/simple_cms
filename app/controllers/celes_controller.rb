class CelesController < ApplicationController


def new
	@nowy_cel =  Cele.new
end

def create 
  @worker = Worker.find(params[:cele][:ce_worker_id])
    @nowy_cel =  Cele.new(params[:cele])
    if @nowy_cel.save 
    	flash[:notice] = "Poprawnie dodano cel"
    	redirect_to szczegoly_po_id_path(@worker.id)
    else
    	flash[:notice] = "Nie udalo sie dodac celu sprawdz poprawnosc wypelnionych pol."
    	redirect_to szczegoly_po_id_path(@worker.id)

	end
end


end
