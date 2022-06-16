class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show update destroy ]

  # GET /tickets
  def index
    @tickets = Ticket.all

    render json: @tickets
  end

  # GET /tickets/1
  def show
    render json: @ticket
  end

  def destroy

  end

  # POST /tickets
  def create
    # validate that num of tags is less than 5
    if tags_params.count < 5

      # validate that title and user ID are present
      @ticket = Ticket.new(ticket_params)
      if @ticket.save
        render json: @ticket, status: :created, location: @ticket

        # loop through each tag in tag params and add to tags table
        tags_params.each do |tag|
          @tag = Tag.new(tag_name: tag, num_occurrences: 1, ticket: @ticket)
          @tag.save
        end

        # call most used tag method from tag model
        most_used_tag = Tag.return_most_used_tag
        response = HTTParty.post("https://webhook.site/5ade13a6-120c-46c7-9863-7bfb4ba503bd",
                                 :body => {
                                   :tag => most_used_tag[0],
                                   :count => most_used_tag[1],
                                 }.to_json,
                                 :headers => {'Content-Type' => 'application/json'}
        )
      # if title or user ID are not present, return error to sender
      else
        render json: @ticket.errors, status: :unprocessable_entity
      end

    # if num of tags is more than 4, return error to sender
    else
      render json: {error: "The ticket can have up to 4 tags."}, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
      @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:user_id, :title)
  end

  def tags_params
    params[:tags]
  end

end
