require 'google_maps_service'
require 'thirdPartyException'
class NearestGasController < ApplicationController
	include ThirdPartyException
	@@gmaps = GoogleMapsService::Client.new(key: 'AIzaSyA1m8l3TCHxDck-TU5_Pzsm2K8yu7ZI8zU')
	@@client = GooglePlaces::Client.new('AIzaSyA1m8l3TCHxDck-TU5_Pzsm2K8yu7ZI8zU')
	@@addressStruct = Struct.new(:streetAddress, :city, :state, :postalCode)	
	
	def challenge

		if !Rails.cache.read('address').blank? 
			return response_success(Rails.cache.read('address') )
		else
		  	lat = params[:lat]
		  	lng = params[:lng]
		  	if lng.blank? or lat.blank?
		  		return response_error("Invalid request. Missing the 'lat' or 'lng' parameter.")
		  	end
		  	origin = [lat, lng]
		  	# fomatted_address exception check
		  	formatted_address = has_Formatted_address(@@gmaps,origin)
		  	if !formatted_address
		  		return response_error("Invalid request. 'lat' or 'lng' are not available")
		  	end
		  	formatted_address = formatted_address.split(',')
		  	# userAddress assginment exception check
		  	userAddress = addressStructCreate(formatted_address, 	@@addressStruct.new)
			if !userAddress
				return response_error('Invalid request. No available address')
			end
			# spots exception check
		  	spots = has_Spots(@@client, origin)
		  	if !spots
		  		return response_error('Invalid request. No gas station is near you')
		  	end
		  	nearest_gas = find_nearest_spot(origin, spots)
		  	# gasStationAddress assginment exception check
		  	gasStationAddress = addressStructCreate(nearest_gas, 	@@addressStruct.new)
		  	if !gasStationAddress
				return response_error('Invalid request. No available address')
			end
			Rails.cache.write('address', {'address': userAddress, 'nearest_gas_station': gasStationAddress, }.to_json,expires_in: 5.seconds)
			return response_success({'address': userAddress, 'nearest_gas_station': gasStationAddress,})
	  	end
	end

	def find_nearest_spot(origin, spots)
		gas_distance = 999999
		nearest_gas = nil
		origin = [origin]
		for spot in spots 
	  		gas_lat = spot[:lat]
	  		gas_lng = spot[:lng]
	  		destination = [[gas_lat, gas_lng]]
		  	matrix = @@gmaps.distance_matrix(origin, destination)
		  	if matrix[:rows][0][:elements][0][:distance][:value] < gas_distance
		  		gas_distance = matrix[:rows][0][:elements][0][:distance][:value]
		  		nearest_gas = matrix[:destination_addresses][0].split(',')
		  		puts nearest_gas
		  	end	  	
	  	end
	  	return nearest_gas
	end
end