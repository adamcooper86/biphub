module ChartDataHelper
  def school_data school, options = {}
    date_range = school.observation_date_range options
    formatted_return = date_range.map{|date| [date, school.avg_student_performance({date: date}.merge(options))] }
    formatted_return = [['Day', 'Performance']] + formatted_return
  end
end