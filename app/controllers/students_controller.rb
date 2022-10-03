class StudentsController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordInvalid, with: :response_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :student_not_found  

    def index 
        students = Student.all
        render json: students, status: :ok
    end 

    def show 
        student = find_student
        render json: student, status: :ok
    end

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    end 

    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :accepted
    end 

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    # Private 
    private
    def find_student 
        Student.find(params[:id])
    end

    def student_params 
        params.permit(:name, :major, :age, :instructor_id)
    end

    def student_not_found
        render json: {error: "Student not found"}, status: :not_found
    end

    def response_unprocessable_entity(err)
        render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
    end

end
