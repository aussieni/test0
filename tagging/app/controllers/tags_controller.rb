class TagsController < ApplicationController
  def show
    entity = Entity.where(entity_params).first
    
    if entity
      tags = entity.tags.map { |t| t.text }.sort
      render json: entity_params.merge({tags: tags})
    else
      render nothing: true, status: 404
    end
  end

  def create
    old_entity = Entity.where(entity_params).first
    if old_entity
      old_entity.destroy
    end

    entity = Entity.new(entity_params)
    entity.save
    params[:tags].each do |text|
      Tag.new(entity: entity, text: text).save
    end
    
    render nothing: true
  end

  def delete
    old_entity = Entity.where(entity_params).first
    if old_entity
      old_entity.destroy
      render nothing: true
    else
      render nothing: true, status: 404
    end
  end

  private

  def entity_params
    params.permit(:entity_type, :entity_id)
  end
end
