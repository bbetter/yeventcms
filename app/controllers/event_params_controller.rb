class EventParamsController < ApplicationController
    before_action :set_event_param, only: [ :show, :edit, :update, :destroy ]
    before_action :authenticate_admin!, except: [ :index, :show ]

    def index
      @event_params = EventParam.all.order(:name)
    end

    def show
    end

    def new
      @event_param = EventParam.new
    end

    def create
      @event_param = EventParam.new(event_param_params)
      if @event_param.save
        redirect_to @event_param, notice: 'Event parameter was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @event_param.update(event_param_params)
        redirect_to @event_param, notice: 'Event parameter was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @event_param.destroy
      redirect_to event_params_url, notice: 'Event parameter was successfully destroyed.'
    end

    private

    def set_event_param
      @event_param = EventParam.find(params[:id])
    end

    def event_param_params
      params.require(:event_param).permit(:name, :description)
    end
end
