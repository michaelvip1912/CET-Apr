class AcademiesController < ApplicationController
  before_action :set_academy, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize

  def index
    @academies = Academy.paginate(page: params[:page])
  end

  def show
  end

  def new
    @academy = Academy.new
  end

  def edit
  end

  def create
    @academy = Academy.new(academy_params)

    respond_to do |format|
      if @academy.save
        format.html { redirect_to @academy, notice: 'Academy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @academy }
      else
        format.html { render action: 'new' }
        format.json { render json: @academy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @academy.update(academy_params)
        format.html { redirect_to @academy, notice: 'Academy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @academy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @academy.destroy
    respond_to do |format|
      format.html { redirect_to academies_url }
      format.json { head :no_content }
    end
  end

  private
    def set_academy
      @academy = Academy.find(params[:id])
    end

    def academy_params
      params[:academy]
    end
end
