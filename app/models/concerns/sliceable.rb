module Sliceable
  extend ActiveSupport::Concern

  def make_selectors options
    trailing = options.fetch(:trailing, nil)
    date = options.fetch(:date, nil)
    grade = options.fetch(:grade, nil)
    gender = options.fetch(:gender, nil)
    race = options.fetch(:race, nil)
    speducator_id = options.fetch(:speducator_id, nil)

    selectors = {}
    selectors[:grade] = grade if grade
    selectors[:gender] = gender if gender
    selectors[:race] = race if race
    selectors[:speducator_id] = speducator_id if speducator_id
    selectors
  end
end