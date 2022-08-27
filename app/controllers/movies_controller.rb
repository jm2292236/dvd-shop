class MoviesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Movie.all
    end

    def show
        render json: find_movie
    end

    private

    def find_movie
        Movie.find(params[:id])
    end

    def render_record_not_found_response
        render json: {error: "Movie not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
