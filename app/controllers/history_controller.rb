# app/controllers/history_controller.rb
class HistoryController < ApplicationController
    def index
      @versions = PaperTrail::Version.order(created_at: :desc)
    end
end