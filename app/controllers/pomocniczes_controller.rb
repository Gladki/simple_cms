class PomocniczesController < ApplicationController
 
    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create,:create_dodatek]
before_filter :normatywy_by_id, :only => [:delete]
before_filter :dodatki_by_id, :only => [:delete_dodatek]

def normatywy_by_id
    @predkosc = Predkosci.find(params[:id])
end

def dodatki_by_id
  @dodatek = Dodatki.find(params[:id])
end

def normatywy_all
    @predkosci = Predkosci.all
    @dodatki = Dodatki.all
end

def new
  # @nowa_predkosc =  Predkosci.new
	# @nowy_dodatek =  Dodatki.new
end

def create 

    @nowa_predkosc =  Predkosci.new(params[:predkosci])
    @nowy_dodatek =  Dodatki.new(params[:dodatki])
   if @nowy_dodatek.save ||  @nowa_predkosc.save
      redirect_to :action => "index"  
      flash[:notice] = "Poprawnie dodano dodatek"
    else
      flash[:notice] = "Nie udalo sie dodac dodatku sprawdz poprawnosc wypelnionych pol."
      render "index"
    end
  


end
def create_dodatek
    @nowa_predkosc =  Predkosci.new(params[:predkosci])
    @nowy_dodatek =  Dodatki.new(params[:dodatki])
   if @nowy_dodatek.save
      redirect_to :action => "index"  
      flash[:notice] = "Poprawnie dodano predkosc"
    else
      flash[:notice] = "Nie udalo sie dodac predkosci sprawdz poprawnosc wypelnionych pol."
      render "index"
    end
  
end

def index

@nowa_predkosc =  Predkosci.new
@nowy_dodatek =  Dodatki.new
end

def delete
    if @predkosc.destroy
      redirect_to :action => "index" 
      flash[:notice] = "Poprawnie usunieto predkosc z bazy"
    else
      redirect_to :action => "index" 
      flash[:notice] = "Nie udalo sie usunac predkosci."
    end
  end
def delete_dodatek
    if @dodatek.destroy
      redirect_to :action => "index" 
      flash[:notice] = "Poprawnie usunieto dodatek z bazy"
    else
      redirect_to :action => "index" 
      flash[:notice] = "Nie udalo sie usunac dodatku."
    end
  end
def export
	respond_to do |format|
    	format.html
    	format.xls 	
	end
end

end
