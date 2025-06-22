module Api
  module V1
    class TrainingRecordsController < ApplicationController
      before_action :set_training_menu
      before_action :set_user

      def index
        records = @training_menu.training_records.where(user: @user).order(recorded_at: :desc)
        render json: records
      end

      def create
        record = @training_menu.training_records.new(record_params.merge(user: @user))
        if record.save
          render json: record, status: :created
        else
          render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_training_menu
        @training_menu = TrainingMenu.find(params[:training_menu_id])
      end

      def set_user
        @user = User.first
      end

      def record_params
        params.require(:training_record).permit(:count, :recorded_at)
      end
    end
  end
end
