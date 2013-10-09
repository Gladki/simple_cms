class PremiesController < ApplicationController

    filter_access_to :all


before_filter :find_worker , :only => [:create]
before_filter :premia_id , :only => [:delete]

def find_worker
     @worker = Worker.find(params[:premie][:pe_worker_id])
    
end
def premia_id
    if params[:id2] != nil
        @premia = Premie.find(params[:id2])
    else
        @premia = Premie.find(params[:id])
    end
end

def new
	@nowa_premia =  Premie.new
end

def create 
    @nowa_premia =  Premie.new(params[:premie])
    if @nowa_premia.save 
    	flash[:notice] = "Poprawnie dodano premie"
    	redirect_to szczegoly_po_id_path(@worker.id)
    else
    	flash[:notice] = "Nie udalo sie dodac premii sprawdz poprawnosc wypelnionych pol."
    	redirect_to szczegoly_po_id_path(@worker.id)

	end
end
def delete

    if @premia.destroy
    flash[:notice] = "Poprawnie usunieto cel."
        redirect_to szczegoly_po_id_path(params[:id])
    else
    flash[:notice] = "Nie udalo sie usunac celu."
        redirect_to szczegoly_po_id_path(params[:id])
    end
  end

end
