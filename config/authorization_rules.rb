authorization do
	role :admin do	
		has_permission_on :workers, :to => [:index, :show, :lista, :new ,:create,:delete,:pracownik,:szczegoly,:import_render,:import]
		has_permission_on :searches, :to => [:new,:index,:create,:show]
	end

	role :dyrektor do	
		has_permission_on :workers, :to => [:index, :show, :lista, :new ,:create,:delete,:pracownik,:szczegoly,:import_render,:import]
		has_permission_on :searches, :to => [:new,:index,:create,:show]
	end
	role :kierownik do	
		has_permission_on :workers, :to => [:index, :show, :lista ,:create,:pracownik,:szczegoly,:import_render,:import]
	end

	role :pracownik do	
		has_permission_on :workers, :to => [:index, :szczegoly]
	end

	role :gosc do	
		has_permission_on :workers, :to => :index
	end
end