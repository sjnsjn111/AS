class DepartmentsController < BaseNotificationsController
  def index
    @departments = Department.newest.includes :subjects
  end
end
