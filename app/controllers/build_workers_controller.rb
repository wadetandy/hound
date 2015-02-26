class BuildWorkersController < ApplicationController
  skip_before_filter :authenticate

  def update
    build_worker = find_build_worker

    if not build_worker.completed?
      CommentingJob.perform_later(build_worker, violations)
      mark_as_complete(build_worker)

      render json: {}, status: 201
    else
      error = "BuildWorker##{build_worker.id} has already been finished"

      render json: { error: error }, status: 412
    end
  end

  private

  def mark_as_complete(build_worker)
    build_worker.update_attribute(:completed_at, Time.now)
  end

  def violations
    params[:violations]
  end

  def find_build_worker
    @find_build_worker ||= BuildWorker.find(params[:id])
  end
end
