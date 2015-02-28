module ApplicationHelper
	
	def shallow_args(parent, child)
	  params[:action] == 'new' ? [parent, child] : child
	end

	def is_user_owner?(resource)
		resource.user_id == current_user.id
	end

	def handle_popups
		if flash[:alert].nil?
			flash[:alert] = flash[:notice]
		end
	end

end
