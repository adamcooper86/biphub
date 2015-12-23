module ChartDataHelper
  def school_data school
    date_range = school.observation_date_range
    formatted_return = date_range.map{|date| [date, school.avg_student_performance(date: date)] }
    formatted_return = [['Day', 'Performance']] + formatted_return
  end
end