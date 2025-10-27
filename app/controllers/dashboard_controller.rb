class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.teacher? || current_user.admin?
      redirect_to teacher_dashboard_path
    else
      redirect_to student_dashboard_path
    end
  end

  def teacher_dashboard
    # 教師が担当するコース
    @courses = current_user.taught_courses.includes(:lessons)

    # 生徒からの未回答の質問
    @unanswered_questions = StudentQuestion.unanswered
      .includes(:student, :lesson)
      .joins(lesson: :course)
      .where(courses: { teacher_id: current_user.id })
      .order(created_at: :desc)
      .limit(10)

    render inertia: "Dashboard/Teacher", props: {
      courses: @courses.as_json(include: :lessons),
      unanswered_questions: @unanswered_questions.as_json(
        include: {
          student: { only: [ :id, :name ] },
          lesson: { only: [ :id, :title ], include: { course: { only: [ :id, :title ] } } }
        }
      ),
      user: current_user.as_json(only: [ :id, :name, :email, :role ])
    }
  end

  def student_dashboard
    # 今日の学習計画
    @today_plans = current_user.learning_plans
      .pending
      .where("scheduled_at::date = ?", Date.today)
      .includes(lesson: :course)

    # 最近の学習記録
    @recent_records = current_user.learning_records
      .includes(lesson: :course)
      .order(created_at: :desc)
      .limit(5)

    # 今後の学習計画
    @upcoming_plans = current_user.learning_plans
      .upcoming
      .includes(lesson: :course)
      .limit(10)

    # 未回答の質問
    @my_questions = current_user.student_questions
      .unanswered
      .includes(:lesson)
      .order(created_at: :desc)
      .limit(5)

    render inertia: "Dashboard/Student", props: {
      today_plans: @today_plans.as_json(include: { lesson: { include: :course } }),
      recent_records: @recent_records.as_json(include: { lesson: { include: :course } }),
      upcoming_plans: @upcoming_plans.as_json(include: { lesson: { include: :course } }),
      my_questions: @my_questions.as_json(include: :lesson),
      user: current_user.as_json(only: [ :id, :name, :email, :role ])
    }
  end
end
