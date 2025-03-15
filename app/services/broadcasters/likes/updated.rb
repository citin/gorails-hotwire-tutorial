class Broadcasters::Likes::Updated
  include ActionView::RecordIdentifier

  attr_reader :record

  def initialize(record)
    @record = record
  end

  def call
    update_likes_count
    update_current_user_likes
  end

  private

  def update_likes_count
    Turbo::StreamsChannel.broadcast_update_to collection_name,
      target: dom_id(record, :likes_count), html: record.likes_count
  end

  def update_current_user_likes
    Turbo::StreamsChannel.broadcast_update_to Current.user, collection_name,
      target: dom_id(record, :likes), partial: "shared/likes", locals: { record: record  }
  end

  def collection_name
    record.model_name.plural
  end
end
