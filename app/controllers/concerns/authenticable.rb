module Authenticable
	

	def api_current_user
		#if request.headers["Authorization"] != nil
			#@current_user ||= User.find_by(auth_token: request.headers["Authorization"])
		#else
			#super if defined?(super)
		#end
		@api_current_user ||= User.find_by(auth_token: request.headers["Authorization"])

	end

	def api_authenticate_with_token!
		render json: { errors: "Not authenticated" }, status: :unauthorized unless api_user_signed_in?
	end

	def api_user_signed_in?
		api_current_user.present?
	end
end