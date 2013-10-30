module Api
  class ActivitiesController < ApplicationController
    def index
      render json: { activities: Activity.order(priority: :desc) }
    end

    def create
      activity = Activity.create!(ActivityParams.permit params)
      render json: { activity: activity }, status: 201
    end

    def update
      activity = Activity.find(params[:id])
      activity.update_attributes!(ActivityParams.permit params)
      render json: {}, status: 204
    end

    def sort
      Activity.transaction do
        Array(params[:activities]).reverse.each_with_index do |activity_id, index|
          Activity.find(activity_id).update_attributes!(priority: index)
        end
      end
      render json: {}, status: 204
    end

    def destroy
      Activity.find(params[:id]).destroy!
      render json: {}, status: 204
    end

    class ActivityParams
      def self.permit params
        params.
          require(:activity).
          permit(:name)
      end
    end
  end
end
