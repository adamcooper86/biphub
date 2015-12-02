class CardsController < ApplicationController

  def new
    @school = School.find_by_id params[:school_id]
    @student = Student.find_by_id params[:student_id]
    @card = Card.new
  end

  def create
    school = School.find_by_id params[:school_id]
    student = Student.find_by_id params[:student_id]
    card = Card.new card_params
    if card.save
      student.cards << card
      redirect_to school_student_path school, student
    else
      redirect_to new_school_student_card_path school, student
    end
  end

  def show
  	@user = current_user
  	@card = Card.find_by_id params[:id]
	  @teacher = @card.user
  	@student = @card.student
  end

  def edit
  	@card = Card.find_by_id params[:id]
  	@student = @card.student
    @school = @student.school
  end

  def update
    @school = School.find(params[:school_id])
    @student = Student.find_by_id params[:student_id]
    @card = Card.find_by_id params[:id]
    @card.update_attributes(card_params)
    redirect_to school_student_path @school, @student
  end

  def destroy
    @school = School.find_by_id params[:school_id]
  	@card = Card.find_by_id params[:id]
  	@student = @card.student
  	@card.destroy
  	redirect_to school_student_path @school, @student
  end

private
  def card_params
    params.require(:card).permit(:teacher_id, :start, :end)
  end

end
