class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrolled_in_current_course, only: [:show]

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_enrolled_in_current_course
    if current_user.enrolled_in?(current_lesson.section.course) == false
      redirect_to course_path(current_lesson.section.course), alert: 'Please enroll in the current course'
    end
  end
end
