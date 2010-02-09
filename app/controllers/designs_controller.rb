class DesignsController < ApplicationController
  # GET /designs
  # GET /designs.xml

  def index
    unless params[:rating].nil?
      puts "DESIGN_ID ="
      @design = Design.find_by_id(params[:design_id])
      @total_score = (@design.times_rated) * (@design.rating) + (params[:rating].to_i * 100)
      @design.times_rated += 1
      @design.rating = (@total_score / @design.times_rated)
      @design.save      
    end
    # @designs = Design.all
    redirect_to view_designs_url(:id => pick_design)

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @designs }
    # end
  end
  
  # GET /designs/1
  # GET /designs/1.xml
  def show

    @design = Design.find(params[:id])
    if @design.approved == false
      redirect_to 'public/404.html' and return false
    else
      @creator = User.find_by_id(@design.user_id)
      session[:design_id] = params[:id]
      @comments = Comment.design_id_like(@design.id)
    end
    
    if @new_comment.nil?
      @new_comment = Comment.new
    end
  
    respond_to do |format|
      format.html { render :layout => 'public'}
      format.xml  { render :xml => @design }
    end
  end
  
  
  # GET /designs/new
  # GET /designs/new.xml
  def new
    @design = Design.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design }
    end
  end

  # GET /designs/1/edit
  def edit
    @design = Design.find(params[:id])
  end

  # POST /designs
  # POST /designs.xml
  def create
    @design = Design.new(params[:design])

    respond_to do |format|
      if @design.save
        flash[:notice] = 'Design was successfully created.'
        format.html { redirect_to(@design) }
        format.xml  { render :xml => @design, :status => :created, :location => @design }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /designs/1
  # PUT /designs/1.xml
  def update
    @design = Design.find(params[:id])

    respond_to do |format|
      if @design.update_attributes(params[:design])
        flash[:notice] = 'Design was successfully updated.'
        format.html { redirect_to(@design) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /designs/1
  # DELETE /designs/1.xml
  def destroy
    @design = Design.find(params[:id])
    @design.destroy

    respond_to do |format|
      format.html { redirect_to(designs_url) }
      format.xml  { head :ok }
    end
  end

  private
  
    def pick_design
      @number_designs = Design.last.id
      while @picked_design == nil or @picked_design.approved == false
        @picked_design = Design.find_by_id(1 + rand(@number_designs))
      end
      return @picked_design.id
    end
    
    
end
