class IdeasController < ApplicationController
  # POST /iseas
  def create
    @idea = Idea.new(idea_params)
    @category = Category.new(category_params)
    caategory = Category.find_by(name: @category.name)
    @name = category.name
    if !@name.nil?
      @idea.category_id = caategory.id
    elsif @category.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end
    if @idea.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end
  end

  # GET /ideas
  def index
    Category.joins(:ideas)
    @category = Category.new(category_params)
    if @category.name != ''
      category = Category.joins(:ideas).where(name: @category.name)
      render status: 404, json: { status: 404 } if category == ''
      render json: { data: [{ "id": category.ideas.id, "category": category.name, "body": category.ideas.body }] }
    end
    @ideas = Idea.all
    render json: { data: [{ "id": category.ideas.id, "category": category.name, "body": category.ideas.body }] }
  end

  def idea_params
    params.require(:idea).permit(:body, :category_id, categories_attributes: [:name])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
