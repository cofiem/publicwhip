# frozen_string_literal: true

module Api
  module V1
    class DivisionsController < Api::V1::ApplicationController
      def index
        @divisions = Division.order(date: :desc, house: :desc, number: :desc).includes(:wiki_motions, :whips, :division_info).limit(100)
        @divisions = @divisions.where(date: (params[:start_date])..) if params[:start_date]
        @divisions = @divisions.where(date: ..(params[:end_date])) if params[:end_date]
        @divisions = @divisions.where(house: params[:house]) if params[:house]
      end

      def show
        @division = Division.find(params[:id])
      end
    end
  end
end
