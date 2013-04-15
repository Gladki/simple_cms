class PomocniczesController < ApplicationController
 
    filter_access_to :all

 layout 'worker'
before_filter :normatywy_all, :only => [:index,:export,:create,:create_dodatek,:create_obszar]
before_filter :normatywy_by_id, :only => [:delete,:update_predkosc,:edit_predkosc]
before_filter :dodatki_by_id, :only => [:delete_dodatek,:update_dodatek,:edit_dodatek]
before_filter :obszar_by_id, :only => [:delete_obszar, :update_obszar,:edit_obszar]
before_filter :new_make, :only => [:create, :create_dodatek, :create_obszar]
respond_to :html, :json

def normatywy_by_id
  @predkosc = Predkosci.find(params[:id])
end

def dodatki_by_id
  @dodatek = Dodatki.find(params[:id])
end
def obszar_by_id
  @obszar = Obszar.find(params[:id])
end

def new_make
  @nowa_predkosc =  Predkosci.new(params[:predkosci])
  @nowy_dodatek =  Dodatki.new(params[:dodatki])
  @nowy_obszar =  Obszar.new(params[:obszar])
end

def normatywy_all
    @predkosci = Predkosci.all
    @dodatki = Dodatki.all
    @obszary = Obszar.all
end

def new
  # @nowa_predkosc =  Predkosci.new
	# @nowy_dodatek =  Dodatki.new
end

def create 


   if @nowy_dodatek.save ||  @nowa_predkosc.save || @nowy_obszar.save
      redirect_to :action => "index"  
      flash[:notice] = "Poprawnie dodano dodatek"
    else
      flash[:notice] = "Nie udalo sie dodac dodatku sprawdz poprawnosc wypelnionych pol."
      render "index"
    end
end

def create_dodatek

   if @nowy_dodatek.save
      redirect_to :action => "index"  
      flash[:notice] = "Poprawnie dodano predkosc"
    else
      flash[:notice] = "Nie udalo sie dodac predkosci sprawdz poprawnosc wypelnionych pol."
      render "index"
    end
  
end
def create_obszar
   
   if @nowy_obszar.save
      redirect_to :action => "index"  
      flash[:notice] = "Poprawnie dodano obszar"
    else
      flash[:notice] = "Nie udalo sie dodac obszaru sprawdz poprawnosc wypelnionych pol."
      render "index"
    end
end

def index
  @nowy_obszar = Obszar.new
  @nowa_predkosc =  Predkosci.new
  @nowy_dodatek =  Dodatki.new
end

def edit_obszar
end

def update_obszar
  @obszar.update_attributes(params[:obszar])
  flash[:notice] = "Poprawnie zmieniono obszar."
    redirect_to pomocnicze_path
end

def edit_dodatek

end

def update_dodatek
  @dodatek.update_attributes(params[:dodatki])
  flash[:notice] = "Poprawnie zmieniono dodatek."
    redirect_to pomocnicze_path
    
end
def edit_predkosc

end

def update_predkosc
  @predkosc.update_attributes(params[:predkosci])
  flash[:notice] = "Poprawnie zmieniono predkosc."
    redirect_to pomocnicze_path
    
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
def delete_obszar
  if @obszar.destroy
      redirect_to :action => "index" 
      flash[:notice] = "Poprawnie usunieto obszar z bazy"
    else
      redirect_to :action => "index" 
      flash[:notice] = "Nie udalo sie usunac obszaru."
    end
  end
def export
	respond_to do |format|
    	format.html
    	format.xls 	
	end
end

end
