module Request
	module JsonHelpers
		def json_response
			@json_response = JSON.parse(response.body, symbolize_names: true)
		end
	end

	module OpenTimeHelpers
		def open_time
			@open_time = {day1: "foo", day2: "bar"}
		end
	end
end