class InstructorsController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found
    def index
        instructors = Instructor.all 
        render json: instructors, status: :ok
    end

    def show
        instructor = find_instructor
        render json: instructor, status: :ok 
    end

    def create

        instructor=Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end 

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy 
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end

    # Private methods 
    private 
    def find_instructor
        Instructor.find(params[:id])
    end 

    def instructor_params
        params.permit(:name)
    end

    def instructor_not_found 
        render json: {error: "Instructor not found"}, status: :not_found
    end 

    def response_unprocessable_entity(err) 
        render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity 
    end
end
