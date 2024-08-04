class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_admin!, only: [:new, :create, :destroy]

    def index
        @events = Event.all

        if params[:search].present?
            @events = @events.where('name LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
        end

    end

    def show
        @comment = Comment.new
    end

    def new
        @event = Event.new
        @event_params = EventParam.all
    end

    def edit
        @event_params = EventParam.all
    end

    def create
        if event_params[:new_category].present?
            category = Category.find_or_create_by(name: event_params[:new_category])
            @event = Event.new(event_params.except(:new_category).merge(category_id: category.id))
        else
            @event = Event.new(event_params.except(:new_category))
        end

        if @event.save
            redirect_to @event, notice: 'Event was successfully created.'
        else
            @event_params = EventParam.all
            render :new
        end
    end

    def update
        if event_params[:new_category].present?
            category = Category.find_or_create_by(name: event_params[:new_category])
            if @event.update(event_params.except(:new_category).merge(category_id: category.id))
                redirect_to @event, notice: 'Event was successfully updated.'
            else
                @event_params = EventParam.all
                render :edit
            end
        else
            if @event.update(event_params.except(:new_category))
                redirect_to @event, notice: 'Event was successfully updated.'
            else
                @event_params = EventParam.all
                render :edit
            end
        end
    end

    def destroy
        @event.destroy
        redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    private

    def set_event
        @event = Event.find(params[:id])
    end

    def event_params
        params.require(:event).permit(
            :name,
            :description,
            :category_id,
            :new_category,
            :ios_impl,
            :android_impl,
            :ios_release,
            :android_release,
            event_param_ids: [],
            attachments: []
        )
    end
end
