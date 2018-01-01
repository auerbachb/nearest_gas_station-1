module ThirdPartyException
	def has_Spots(client, origin)
		begin
	  		spots = client.spots(origin[0], origin[1], :types => 'gas_station')
	  		if spots.blank?
	  			raise 'Invalid request. No gas station is near you'
	  		end
	  	rescue Exception => e
	  		return false
	  	else
	  		return spots
	  	end
	end

	def has_Formatted_address(gmaps, origin)
		begin
	  		formatted_address = gmaps.reverse_geocode({lat:origin[0], lng: origin[1]})[0][:formatted_address]
	  	rescue Exception => e
	  		return e
	  	else
	  		return formatted_address
	  	end
	end

	def addressStructCreate(formatted_address, addressStruct)
		begin
			addressStruct.streetAddress = formatted_address[0].strip
			addressStruct.city = formatted_address[1].strip
			addressStruct.state = formatted_address[2].split(' ')[0].strip
			addressStruct.postalCode = formatted_address[2].split(' ')[1].strip
			if (addressStruct.streetAddress.blank? or addressStruct.city.blank? or 
				addressStruct.state.blank? or addressStruct.postalCode.blank?)
				raise 'error when create address struct'
			end
		rescue Exception => e
			return false
		else
			return addressStruct
		end
	end
end