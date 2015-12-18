module StudentDataHelper
  # def observations_students_options observations
  #     students = observations.map{ |observation| observation.student }
  #     students.map { |student|[student.first_name, student.id] }
  # end

  def chart_row_formatter(student_data)
    rows = []
    student_data.each do |goal|
      goal_row = []
      goal_row << goal["goal"].text
      goal_row << goal["goal"].prompt
      goal["records"].each do |record|
        goal_row << record.result
      end
      rows << goal_row
    end
    return rows
  end

end