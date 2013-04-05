class TypyczynnoscisController < ApplicationController
 
    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create]
before_filter :normatywy_by_id, :only => [:delete]

def normatywy_by_id
    @czynnosc = Typyczynnosci.find(params[:id])
 end
def normatywy_all
    @czynnosci = Typyczynnosci.all
end

def new
	@nowa_czynnosc =  Typyczynnosci.new
end

def create 
  
    @nowa_czynnosc =  Typyczynnosci.new(params[:typyczynnosci])
    if @nowa_czynnosc.save 
    	redirect_to :action => "index"	
    	flash[:notice] = "Poprawnie dodano czynnosc"
    else
    	flash[:notice] = "Nie udalo sie dodac czynnosci sprawdz poprawnosc wypelnionych pol."
    	render "index"

	end


end

def index
@nowa_czynnosc =  Typyczynnosci.new
end
 def delete
    if @czynnosc.destroy
      redirect_to :action => "index" 
      flash[:notice] = "Poprawnie usunieto pracownika z bazy"
    else
      redirect_to :action => "index" 
      flash[:notice] = "Nie udalo sie usunac pracownika"
    end
  end
def export
	respond_to do |format|
    	format.html
    	format.xls 	
	end
end

end
