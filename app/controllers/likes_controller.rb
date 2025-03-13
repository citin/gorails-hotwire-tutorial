class LikesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_record

  def update
    if @record.liked_by?(Current.user)
      @record.unlike(Current.user)
    else
      @record.like(Current.user)
    end

    @record.broadcast_update_to "posts",
      target: dom_id(@record, :likes_count),
      partial: "shared/likes_count",
      locals: { record: @record }

    render partial: "shared/likes", locals: { record: @record }
  end

  private

  def set_record
    name = params.dig(:resource).singularize
    klass = name.classify.constantize
    param_name = "#{name}_id"
    @record = klass.find(params[param_name])
  end
end
