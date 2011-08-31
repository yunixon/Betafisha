# == Schema Information
#
# Table name: bookmaker_coefficients
#
#  id             :integer(4)      not null, primary key
#  bookmaker_id   :string(255)
#  sport_id       :string(255)
#  league_id       :string(255)
#  team_one_id    :string(255)
#  team_two_id    :string(255)
#  sportsmen_id   :string(255)
#  bet_type_id    :string(255)
#  team_one_coef  :string(255)
#  team_two_coef  :string(255)
#  sportsmen_coef :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class BookmakerCoefficientsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
