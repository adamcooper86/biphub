class GoalsController < ApplicationController
    def new
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:student_id]
      @bip = Bip.find_by_id params[:bip_id]
      @goal = Goal.new
    end

    def create
      school = School.find_by_id params[:school_id]
      student = Student.find_by_id params[:student_id]
      bip = Bip.find_by_id params[:bip_id]
      goal = Goal.new goal_params
      bip.goals << goal
      if goal.save
        redirect_to school_student_bip_path school, student, bip
      else
        redirect_to new_school_student_bip_goal_path school, student, bip
      end
    end

    def show
      @user = current_user
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:student_id]
      @bip = Bip.find_by_id params[:bip_id]
      @goal = Goal.find_by_id params[:id]
    end

    def edit
      @user = current_user
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:student_id]
      @bip = Bip.find_by_id params[:bip_id]
      @goal = Goal.find_by_id params[:id]
    end

    def update
      @user = current_user
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:student_id]
      @bip = Bip.find_by_id params[:bip_id]
      @goal = Goal.find_by_id params[:id]
      @goal.update_attributes(goal_params)
      redirect_to school_student_bip_path @school, @student, @bip
    end

    def destroy
      @school = School.find_by_id params[:school_id]
      @student = Student.find_by_id params[:student_id]
      @bip = Bip.find_by_id params[:bip_id]
      @goal = Goal.find_by_id params[:id]
      @goal.destroy
      redirect_to school_student_bip_path @school, @student, @bip
    end

  private
    def goal_params
      params.require(:goal).permit(:prompt, :text, :meme)
    end
end
