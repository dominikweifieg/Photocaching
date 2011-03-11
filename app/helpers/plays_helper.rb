module PlaysHelper
  def map(source, destination)
    "<iframe width='425' height='350' frameborder='0' scrolling='no' marginheight='0' marginwidth='0' src='http://maps.google.com/maps?f=d&amp;source=s_d&amp;saddr=#{source.lat},#{source.lng}&amp;daddr=#{destination.lat},#{destination.lng}&amp;hl=en&amp;mra=ls&amp;dirflg=w&amp;ie=UTF8&amp;t=h&amp;output=embed'></iframe><br /><small><a href='http://maps.google.com/maps?f=d&amp;source=embed&amp;saddr=#{source.lat},#{source.lng}&amp;daddr=#{destination.lat},#{destination.lng}&amp;hl=en&amp;mra=ls&amp;dirflg=w&amp;ie=UTF8&amp;t=h' style='color:#0000FF;text-align:left'>View Larger Map</a></small>".html_safe
  end
end
