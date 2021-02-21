module Api
  module V1
    class UnitiesController < ApplicationController
      before_action :set_params_for_filter, only: [:find_ubs]
      
      def find_ubs
        ubs = UbsServices.csv_import(@geocodes, @page, @per_page)
        if ubs.present?
          render json:  ubs, status: 200 
        else
          render json:  ubs, status: 401 
        end
      end

      private

      def set_params_for_filter
        @geocodes = filters_by_search[:query].split (',')
        @page = filters_by_search[:page].to_i
        @per_page =  filters_by_search[:per_page].present? ? filters_by_search[:per_page].to_i : 10
      end

      def filters_by_search
        params.permit(:query, :page, :per_page)
      end
    end
  end
end
