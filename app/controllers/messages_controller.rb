class MessagesController < ApplicationController
  before_action :set_group

  def index
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = @group.messages.includes(:user)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = @group.messages.new(message_params)
    logger(@message.save)
logger(@message.errors)
logger(@message.errors.full_messages)
    if @message.save
    respond_to do |format|
      format.html { redirect_to group_messages_path(params[:group_id]) }
      format.json
    end
  else
    render :index
  end
    # if @message.save
      # redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    # else
    #   @messages = @group.messages.includes(:user)
    #   flash.now[:alert] = 'メッセージを入力してください。'
    #   render :index
    # end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
