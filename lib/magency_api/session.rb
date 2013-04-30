# encoding: utf-8
require 'net/http'
require 'uri'
require 'json'
require 'active_support'


module MagencyAPI
	class Session
		MAGENCY_API_URL = 'www.mskagency.ru/api/v1/'
		MAGENCY_METHODS = %w(upload_material get_material login)
		attr_accessor :login, :password


		def initialize(login, password)
			@login, @password = login, password
		end


		def call(method, params={})
			method = method.to_s
			response = JSON.parse(Net::HTTP.post_form(URI.parse("http://#{@login}:#{@password}@"+ MAGENCY_API_URL + method), params).body)

			raise ServerError.new self, method, params, response['error'] if response['error']
			response
		end


		def self.add_method method
			::MagencyAPI::Session.class_eval do
				define_method method do 
					unless (var = instance_variagle_get("@#{method}"))
						instance_variagle_set("@#{method}", var = ::MagencyAPI::Session.new(login,password,method))
					end
					var
				end
			end
		end


		for method in MAGENCY_METHODS
			add_method method
		end


		# Delegate to server Magency missing methods
		def method_missing(name, *args)
			call name, *args
		end
	end


	# Base error class
	class Error < ::StandardError; end


	class ServerError < Error
		attr_accessor :session, :method, :params, :error

		def initialize(session, method, params, error)
			super "Server side error calling Magency method: #{error}"
			@session, @method, @params, @error = session, method, params, error
		end
	end
end