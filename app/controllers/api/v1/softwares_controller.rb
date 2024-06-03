class SoftwaresController < ApplicationController
  before_action :set_software, only: %i[ show edit update destroy ]

  # GET /softwares or /softwares.json
  def index
    @softwares = Software.all
  end

  # GET /softwares/1 or /softwares/1.json
  def show
  end

  # GET /softwares/new
  def new
    @software = Software.new
  end

  # GET /softwares/1/edit
  def edit
  end

  # POST /softwares or /softwares.json
  def create
    @software = Software.new(software_params)

    respond_to do |format|
      if @software.save
        format.html { redirect_to software_url(@software), notice: "Software was successfully created." }
        format.json { render :show, status: :created, location: @software }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /softwares/1 or /softwares/1.json
  def update
    respond_to do |format|
      if @software.update(software_params)
        format.html { redirect_to software_url(@software), notice: "Software was successfully updated." }
        format.json { render :show, status: :ok, location: @software }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /softwares/1 or /softwares/1.json
  def destroy
    @software.destroy!

    respond_to do |format|
      format.html { redirect_to softwares_url, notice: "Software was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software
      @software = Software.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def software_params
      params.require(:software).permit(:name, :type, :description, :image)
    end
end
