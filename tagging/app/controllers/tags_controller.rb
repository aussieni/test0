class TagsController < ApplicationController
  def show
    entity = Entity.where(
      entity_type: params[:entity_type],
      entity_id: params[:entity_id]
    ).first
    
    if entity
      render json: {
        entity_type: params[:entity_type],
        entity_id: params[:entity_id],
        tags: []
      }
    else
      render nothing: true, status: 404
    end
  end

  def create
    entity = Entity.new(
      entity_type: params[:entity_type],
      entity_id: params[:entity_id]
    )
    entity.save
    
    render json: {}
  end
end
