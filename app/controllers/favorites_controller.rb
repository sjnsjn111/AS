class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  before_action :load_major, only: %i(create destroy)
  before_action :load_favorite_majors, only: :index
  load_and_authorize_resource

  def index; end

  def create
    if @major && is_not_favorite?
      favorite = current_user.favorites.new major_id: params[:major_id]
      unless favorite.save
        @flash = t "process_errors"
      end
    end
  end

  def destroy
    favorite = current_user.favorites.find_by id: params[:id]
    unless favorite && favorite.destroy
      @flash = t "process_errors"
    end
  end

  private

  def load_major
    @major = Major.find_by id: params[:major_id]
    return if @major
    @flash = t "process_errors"
  end

  def is_not_favorite?
    current_user.favorites.find_by(major_id: params[:major_id]).blank?
  end

  def load_favorite_majors
    major_favorite_ids = current_user.favorites.pluck(:major_id)
    @majors = Major.get_by(major_favorite_ids).page(params[:page]).per Settings.per_page
  end
end
