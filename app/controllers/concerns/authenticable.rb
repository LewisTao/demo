module Authenticable
	

		def current_user
			if request.headers["Authorization"] != nil
				current_user ||= User.find_by(auth_token: request.headers["Authorization"])
			else
				super if defined?(super)
			end
		end

		def authenticate_with_token!
			unless user_signed_in?
				respond_to do |format|
					format.html { redirect_to root_path, notice: "Not authenticated" }
					format.json { render json: { errors: "Not authenticated" }, status: :unauthorized }
				end
			end
		end

		def user_signed_in?
			current_user.present?
		end
end