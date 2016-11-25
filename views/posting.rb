# frozen_string_literal: true

PostingView = Struct.new(
  :id, :created_time, :main_description,
  :attachment_title, :attachment_description,
  :attachment_url, :attachment_media_url
)
