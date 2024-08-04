class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event

    def create
      @comment = @event.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to @event, notice: 'Comment was successfully created.'
      else
        redirect_to @event, alert: 'Failed to create comment.'
      end
    end

    def destroy
      @comment = @event.comments.find(params[:id])
      @comment.destroy
      redirect_to @event, notice: 'Comment was successfully destroyed.'
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def comment_params
      params.require(:comment).permit(:content, attachments: [])
    end
end
