class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
  
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
      handle_category
      handle_event_params
  
      @event = Event.new(db_only_params.merge(category_id: @category.id, event_param_ids: @event_param_ids))
  
      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        flash.now[:alert] = 'There was an error creating the event. Please check the form for details.'
        @event_params = EventParam.all
        render :new
      end
    end
  
    def update
      handle_category
      handle_event_params

      puts @category
      puts @event_param_ids
  
      if @event.update(db_only_params.merge(category_id: @category.id, event_param_ids: @event_param_ids))
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        @event_params = EventParam.all
        flash.now[:alert] = 'There was an error updating the event. Please check the form for details.'
        render :edit
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
  
    def custom_params
      params.require(:event).permit(
        :name,
        :description,
        :category_id,
        :ios_impl,
        :android_impl,
        :ios_release,
        :android_release,
        :new_category,
        new_event_params: [],
        event_param_ids: [],
        attachments: []
      )
    end

    def db_only_params
      custom_params.except(:new_category, :new_event_params)
    end

    def handle_category
        if custom_params[:new_category].present?
            @category = Category.find_or_create_by(name: custom_params[:new_category])
        else
            @category = Category.find(custom_params[:category_id])
        end
    end
  
    def handle_event_params
      @event_param_ids = custom_params[:event_param_ids] || []
  
      if custom_params[:new_event_params].present?
        custom_params[:new_event_params].each do |param_name|
          next if param_name.blank?
  
          new_param = EventParam.find_or_create_by(name: param_name)
          @event_param_ids << new_param.id if new_param.persisted?
        end
      end
    end
  end