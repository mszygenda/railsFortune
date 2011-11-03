class CommentsController < ApplicationController
  def vote
    @comment = Comment.find_by_id params[:id]
    @user = current_user
    @already_voted = !@user.nil? ? @user.voted_on?(@comment) : false

    if(!@user.nil? && !@already_voted) 
      if params[:plus].to_i == 1
        @user.vote_for @comment
      else
        @user.vote_against @comment
      end
      respond_to do |format|
        format.js
      end
    end
  end

  # GET /comments
  # GET /comments.json
  def index
    @fortune_id = params[:fortune_id]
    @comments = Comment.where(:fortune_id => @fortune_id)
    
    respond_to do |format|
      format.js
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.save

    respond_to do |format|
      format.js
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end
  end
end
