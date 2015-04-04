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
        tags: entity.tags.map { |t| t.text }.sort
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
    params[:tags].each do |text|
      Tag.new(entity: entity, text: text).save
    end
    
    render json: {}
  end
end
