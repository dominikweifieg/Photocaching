module PhotosHelper
  def map_photo(loc)
    "<iframe width='425' height='350' frameborder='0' scrolling='no' marginheight='0' marginwidth='0' src='http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=#{number_with_precision(loc.lat, :precision=>3)}+#{number_with_precision(loc.lng, :precision=>3)}&amp;aq=&amp;sll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}&amp;sspn=0.005356,0.011094&amp;dirflg=w&amp;ie=UTF8&amp;t=h&amp;z=14&amp;ll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}&amp;output=embed'></iframe><br /><small><a href='http://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=#{number_with_precision(loc.lat, :precision=>3)}+#{number_with_precision(loc.lng, :precision=>3)}&amp;aq=&amp;sll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}&amp;sspn=0.005356,0.011094&amp;dirflg=w&amp;ie=UTF8&amp;t=h&amp;z=14&amp;ll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}' style='color:#0000FF;text-align:left'>View Larger Map</a></small>".html_safe
  end
  
  def map_photo_link(loc)
    "maps://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=#{number_with_precision(loc.lat, :precision=>3)}+#{number_with_precision(loc.lng, :precision=>3)}&amp;aq=&amp;sll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}&amp;sspn=0.005356,0.011094&amp;dirflg=w&amp;ie=UTF8&amp;t=h&amp;z=14&amp;ll=#{number_with_precision(loc.lat, :precision=>3)},#{number_with_precision(loc.lng, :precision=>3)}"
  end
end
