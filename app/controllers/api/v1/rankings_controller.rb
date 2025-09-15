module Api
  module V1
    class RankingsController < ApplicationController
      before_action :set_training_menu

      def index
        period = params[:period]&.downcase || "total"
        rankings = RankingService.new(@training_menu, period: period).call
        render json: rankings
      end

      private

      def set_training_menu
        @training_menu = TrainingMenu.find(params[:training_menu_id])
      end
    end
  end
end
