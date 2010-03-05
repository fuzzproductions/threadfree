class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  
  before_filter :authorize_admin
  
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    
    puts "ORIGINAL URI!:"
    puts session[:original_uri]
    
    if request.post?
      puts "POST REQUEST IN CREATE IN COMMENTS!"
      @comment.design_id  = session[:design_id]
      @comment.user_id = session[:user_id]
    end
    
    # respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        redirect_to(session[:original_uri])
        # format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
      #   flash[:error] = "Something went wrong. We're working on it!"
        redirect_to(session[:original_uri])
      #   # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    # end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(session[:original_uri]) }
        # format.xml  { head :ok }
      else
        flash[:notice] = "Something went wrong. We're working on it!"
        format.html { redirect_to(session[:original_uri]) }
        # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
