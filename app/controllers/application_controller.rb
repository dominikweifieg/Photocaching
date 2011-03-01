class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate
    authenticate_or_request_with_http_digest("Photocaching Access") do |user_name|
        case request.format
        when Mime::XML, Mime::ATOM, Mime::JSON
          if user_name == "fact2]yuccas"
            return "cUK4BH_AFfWA}#Sfk{?X1Bh)e" 
          else
            return ""
          end
        else
          user = User.find_by_alias(user_name)
          user.identifier.hash.to_s(36)
        end
      end
  end
end
