class DashboardsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.json do
        @violation_counts = RubyViolations.
          new(current_user.repos.active).
          count
        render json: @violation_counts
      end
    end
  end
end
