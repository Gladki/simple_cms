class User < ActiveRecord::Base

	has_and_belongs_to_many :groups

	attr_accessible :login, :email, :group_ids, :password, :password_confirmation, :created_at, :updated_at

	
	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :login
	validates_uniqueness_of :login
	def role_symbols
		groups.map do |group|
    		group.name.underscore.to_sym
    	end
	end
	def group?(group)
		 # group.to_s
	end

	def self.authenticate(login, password)
		user = find_by_login(login)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end


end
