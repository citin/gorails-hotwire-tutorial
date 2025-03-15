class LikesController < ApplicationController
  before_action :set_record

  def update
    if @record.liked_by?(Current.user)
      @record.unlike(Current.user)
    else
      @record.like(Current.user)
    end

    Broadcasters::Likes::Updated.new(@record).()
  end

  private

  def set_record
    name = params.dig(:resource).singularize
    klass = name.classify.constantize
    param_name = "#{name}_id"
    @record = klass.find(params[param_name])
  end
end
