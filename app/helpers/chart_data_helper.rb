module ChartDataHelper
  def school_data school
    date_range = school.observation_date_range
    date_range.map{|date| [date, school.avg_student_performance(date: date)] }
  end
end