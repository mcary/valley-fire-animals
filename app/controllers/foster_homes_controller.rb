class FosterHomesController < ApplicationController
  before_action :set_foster_home, only: [:show, :edit, :update, :destroy]

  # GET /foster_homes
  # GET /foster_homes.json
  def index
    @foster_homes = FosterHome.all
  end

  # GET /foster_homes/1
  # GET /foster_homes/1.json
  def show
  end

  # GET /foster_homes/new
  def new
    @foster_home = FosterHome.new
  end

  # GET /foster_homes/1/edit
  def edit
  end

  # POST /foster_homes
  # POST /foster_homes.json
  def create
    @foster_home = FosterHome.new(foster_home_params)

    if(params[:foster_home][:animals].blank?)
      flash.now[:error] = 'Please select the type of animals you can board.'
      render 'new'
      return
    end
    
    update_foster_home_animals

    respond_to do |format|
      if @foster_home.save
        format.html { redirect_to @foster_home, notice: 'Foster home was successfully created.' }
        format.json { render :show, status: :created, location: @foster_home }
      else
        format.html { render :new }
        format.json { render json: @foster_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foster_homes/1
  # PATCH/PUT /foster_homes/1.json
  def update
    update_foster_home_animals
    respond_to do |format|
      if @foster_home.update(foster_home_params)
        format.html { redirect_to @foster_home, notice: 'Foster home was successfully updated.' }
        format.json { render :show, status: :ok, location: @foster_home }
      else
        format.html { render :edit }
        format.json { render json: @foster_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foster_homes/1
  # DELETE /foster_homes/1.json
  def destroy
    @foster_home.destroy
    respond_to do |format|
      format.html { redirect_to foster_homes_url, notice: 'Foster home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def update_foster_home_animals
      @foster_home.animal_foster_homes = []
      animals = Animal.find params[:foster_home][:animals]
      animals.each do |animal|
        @foster_home.animal_foster_homes << AnimalFosterHome.new(animal:animal, foster_home:@foster_home)
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_foster_home
      @foster_home = FosterHome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foster_home_params
      params.require(:foster_home).permit(:name, :address, :details, :animals)
    end
end
