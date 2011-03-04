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
  
  def location_for_latitude(lat)
    bucket = "photocaching.test" 
    server = "s3"
    
    logger.info(lat)
    
    if(lat >= -180.0 && lat < -100.0)
      logger.info("us west")
      bucket = "photocaching.us.west"
      server = "s3-us-west-1"
    elsif(lat >= -100.0 && lat < -30.0)
      logger.info("us east")
      bucket = "photocaching.us.east"
      server = "s3"
    elsif(lat >= -30.0 && lat < 60.0)
      logger.info("eu")
      bucket = "photocaching.eu"
      server = "s3-eu-west-1"
    elsif(lat >= 60.0 && lat < 120.0)
      logger.info("asia west")
      bucket = "photocaching.asia"
      server = "s3-ap-southeast-1"
    elsif(lat >= 120.0 && lat <= 180.0)
      logger.info("asia east")
      bucket = "photocaching.asia.east"
      server = "s3-ap-northeast-1"
    end
    
    return "http://#{server}.amazonaws.com/#{bucket}"
  end
end
