class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show update destroy ]

  # do something to query tags table and return the tag with the highest unique count
  def return_most
    most_used_tag = Tag.all.group(:tag_name).count(tag_name).max
    response = HTTParty.post("https://webhook.site/5ade13a6-120c-46c7-9863-7bfb4ba503bd",
                             :body => {:tag => most_used_tag}.to_json,
                             :headers => {'Content-Type' => 'application/json'}
    )
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.fetch(:tag, {})
    end
end
