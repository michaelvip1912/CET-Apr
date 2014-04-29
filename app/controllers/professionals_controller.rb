class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize

  def index
    @professionals = Professional.paginate(page: params[:page])
  end

  def show
  end

  def new
    @professional = Professional.new
  end

  def edit
  end

  def create
    @professional = Professional.new(professional_params)

    respond_to do |format|
      if @professional.save
        format.html { redirect_to @professional, notice: 'Professional was successfully created.' }
        format.json { render action: 'show', status: :created, location: @professional }
      else
        format.html { render action: 'new' }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @professional.update(professional_params)
        format.html { redirect_to @professional, notice: 'Professional was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @professional.destroy
    respond_to do |format|
      format.html { redirect_to professionals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professional_params
      params.require(:professional).permit(:professional_encode, :professional_name)
    end
end
