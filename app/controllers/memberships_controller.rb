class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = Membership.new
    @clubs = BeerClub.all
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create
    if current_user.memberships.where(:beer_club_id => params[:membership][:beer_club_id]).count > 0
      redirect_to beer_clubs_path
      return
    end
    user = User.find(current_user.id)
    unless user.nil?
      params[:membership][:user_id] = current_user.id
    end
    @membership = Membership.new(params[:membership])
    @membership.confirmed = false
    respond_to do |format|
      if @membership.save
        format.html { redirect_to current_user, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  def confirm_member
    membership = Membership.find(params[:id])
    membership.confirmed = true
    membership.save
    redirect_to :back
  end
end
