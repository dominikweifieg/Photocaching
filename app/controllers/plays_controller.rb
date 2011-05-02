class PlaysController < ApplicationController
      protect_from_forgery :except => [:create, :update]
      before_filter :authenticate, :except => [:index, :show]
      
      caches_action :index,  :if => Proc.new { |c| c.request.format.html? }, :cache_path => :index_cache_path.to_proc, :expires_in => 5.minutes
  # GET /plays
  # GET /plays.xml
  def index
    if params[:player_identifier].present?
      user = User.find_by_identifier(params[:player_identifier])
      photo = Photo.find(params[:photo_id])
      @plays = user.plays.find(:all, :conditions => {:photo_id => photo, :end_time => nil})
    else
      @plays = Play.includes([:user, :photo]).where("end_time IS NOT NULL").order("end_time DESC").limit(24);
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plays }
      format.json  { render :json => @plays }
    end
  end

  # GET /plays/1
  # GET /plays/1.xml
  def show
    @play = Play.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @play }
      format.json  { render :json => @play }
    end
  end

  # GET /plays/new
  # GET /plays/new.xml
  def new
    @play = Play.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @play }
      format.json  { render :json => @play }
    end
  end

  # GET /plays/1/edit
  def edit
    @play = Play.find(params[:id])
  end

  # POST /plays
  # POST /plays.xml
  def create
    @play = Play.new(params[:play])
    
    user = User.find_by_identifier(params[:user][:identifier])
    user ||= User.find_by_identifier("ANONYMOUS@photocaching")
    photo = Photo.find(params[:photo][:id]);
    @play.user = user
    @play.photo = photo

    respond_to do |format|
      if @play.save
        
        id = @play.id
        
        path = "play_%08d" % id
       
        location = location_for_longitude(@play.lng)
        
        @play.url = "#{location}/#{path}.jpg"
        @play.thumb = "#{location}/#{path}_thumb.jpg" 
        @play.save
        
        logger.info("Created urls")
        
        format.html { redirect_to(@play, :notice => 'Play was successfully created.') }
        format.xml  { render :xml => @play, :status => :created, :location => @play }
        format.json  { redirect_to(@play, :format => 'json')}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @play.errors, :status => :unprocessable_entity }
        format.json  { render :json => @play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plays/1
  # PUT /plays/1.xml
  def update
    @play = Play.find(params[:id])

    respond_to do |format|
      if @play.update_attributes(params[:play])
        format.html { redirect_to(@play, :notice => 'Play was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @play.errors, :status => :unprocessable_entity }
        format.json  { render :json => @play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.xml
  def destroy
    @play = Play.find(params[:id])
    @play.destroy

    respond_to do |format|
      format.html { redirect_to(plays_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  

  def index_cache_path
    if session["layout"] == "mobile"
      "m_plays.html"
    else
      "plays.html"
    end
  end
end
