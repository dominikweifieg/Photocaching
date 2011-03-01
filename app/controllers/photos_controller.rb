class PhotosController < ApplicationController
  protect_from_forgery :except => :create
  before_filter :authenticate, :except => [:index, :show]
  
  # GET /photos
  # GET /photos.xml
  def index
    limit = params[:limit].to_i if params[:limit].present?
    limt ||= 50
    if(params[:nelat].present?)
      @sw = GeoKit::LatLng.new(params[:swlat].to_f,params[:swlng].to_f)
      @ne = GeoKit::LatLng.new(params[:nelat].to_f,params[:nelng].to_f)
      @origin = GeoKit::LatLng.new(params[:clat].to_f, params[:clng].to_f);
      #@photos = Photo.in_bounds(:bounds => [@sw, @ne], :origin => @origin)
      @photos = Photo.geo_scope(:bounds => [@sw, @ne], :origin => @origin).order("distance asc").limit(limit)
    elsif(params[:within].present?)
      @origin = GeoKit::LatLng.new(params[:clat].to_f, params[:clng].to_f);
      @photos = Photo.within(params[:within].to_f, :origin => @origin).order("distance asc").limit(limit)
    else
      @photos = Photo.all
    end

    logger.info("Found #{@photos.size} photos.")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
      format.json  { render :json => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
      format.json  { render :json => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
      format.json  { render :json => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    user = User.find_by_identifier(params[:user][:identifier]) if params[:user].present?
    user ||= User.find_by_identifier("ANONYMOUS@photocaching")
    
    @photo = Photo.new(params[:photo])
    @photo.user = user;
    
    respond_to do |format|
      if @photo.save
        id = @photo.id
        
        bucket = "photocaching.test" 
        path = "%08d" % id
        
        @photo.url = "http://s3-eu-west-1.amazonaws.com/#{bucket}/#{path}.jpg"
        @photo.thumb = "http://s3-eu-west-1.amazonaws.com/#{bucket}/#{path}_thumb.jpg" 
        @photo.save
        
        logger.info("Created urls")
        
        format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
        format.json  { redirect_to(@photo)}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json  { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice => 'Photo was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        format.json  { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
end
