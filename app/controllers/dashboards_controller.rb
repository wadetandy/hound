class DashboardsController < ApplicationController
  def show
    @violation_counts = RubyViolations.
      new(current_user.repos.active).
      count

    respond_to do |format|
      format.html
      format.json do
        render json: @violation_counts
      end
    end
  end
end
