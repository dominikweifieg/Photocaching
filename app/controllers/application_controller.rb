class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :detect_browser


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
        pwd = user.identifier
        logger.info("#{user} => #{pwd}")
        pwd
      end
    end
  end

  def location_for_longitude(lng)
    bucket = "photocaching.test" 
    server = "s3"

    logger.info(lng)

    if(lng >= -180.0 && lng < -100.0)
      logger.info("us west")
      bucket = "photocaching.us.west"
      server = "s3-us-west-1"
    elsif(lng >= -100.0 && lng < -30.0)
      logger.info("us east")
      bucket = "photocaching.us.east"
      server = "s3"
    elsif(lng >= -30.0 && lng < 60.0)
      logger.info("eu")
      bucket = "photocaching.eu"
      server = "s3-eu-west-1"
    elsif(lng >= 60.0 && lng < 120.0)
      logger.info("asia west")
      bucket = "photocaching.asia"
      server = "s3-ap-southeast-1"
    elsif(lng >= 120.0 && lng <= 180.0)
      logger.info("asia east")
      bucket = "photocaching.asia.east"
      server = "s3-ap-northeast-1"
    end

    return "http://#{server}.amazonaws.com/#{bucket}"
  end

  private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def select_layout
    session.inspect # force session load
    if session.has_key? "layout"
      return (session["layout"] == "mobile") ? "mobile_application" : "application"
    end
    return detect_browser
  end

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      session["layout"] = "mobile" if agent.match(m)
      return "mobile_application" if agent.match(m)
    end
    session["layout"] = "foo"
    return "application"
  end

end
