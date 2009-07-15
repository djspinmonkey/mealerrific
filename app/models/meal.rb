class Meal < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  #before_create :sync_go_gcal

  # Synchronize this meal to GCal.  Currently uses the googlecalendar gem,
  # which uses the bad bad bad login/password authentication instead of
  # AuthSub.
  #
  # TODO: Use some other lib that support AuthSub authentication.
  def sync_to_gcal (login, password)
    title = "#{mealtime}: #{ recipes.collect(&:name).join(' ') }"

    # TODO: Check to see if the meal already exists in GCal.

    g = GData.new
    g.login(login, password)
    g.new_event = { :title => title }
  end
end
