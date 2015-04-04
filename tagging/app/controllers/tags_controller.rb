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
    params[:tags].sort.uniq.each do |text|
      Tag.new(entity: entity, text: text).save
    end
    
    render nothing: true
  end

  def delete
    entity = Entity.where(entity_params).first
    if entity
      entity.destroy
      render nothing: true
    else
      render nothing: true, status: 404
    end
  end

  def entity_stats
    entity = Entity.where(entity_params).first
    if !entity
      render nothing: true, status: 404
      return
    end

    render json: {tag_total: entity.tags.count}
  end

  def stats
    tags = Tag.all.map { |t| t.text }.sort.uniq
    counts = tags.map do |tag|
      {tag: tag, count: Tag.where(text: tag).count}
    end

    render json: counts
  end

  private

  def entity_params
    params.permit(:entity_type, :entity_id)
  end
end
