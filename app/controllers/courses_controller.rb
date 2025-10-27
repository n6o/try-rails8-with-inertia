class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]

  def index
    @courses = Course.includes(:teacher).all
    render inertia: "Courses/Index", props: {
      courses: @courses.as_json(include: { teacher: { only: [ :id, :name ] } })
    }
  end

  def show
    render inertia: "Courses/Show", props: {
      course: @course.as_json(
        include: {
          teacher: { only: [ :id, :name ] },
          lessons: { only: [ :id, :title, :description, :order_index ] }
        }
      )
    }
  end

  def new
    @course = Course.new
    render inertia: "Courses/New"
  end

  def create
    @course = Course.new(course_params)
    @course.teacher = current_user

    if @course.save
      redirect_to course_path(@course), notice: "コースが作成されました。"
    else
      render inertia: "Courses/New", props: {
        errors: @course.errors.full_messages
      }
    end
  end

  def edit
    render inertia: "Courses/Edit", props: {
      course: @course.as_json
    }
  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course), notice: "コースが更新されました。"
    else
      render inertia: "Courses/Edit", props: {
        course: @course.as_json,
        errors: @course.errors.full_messages
      }
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "コースが削除されました。"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
