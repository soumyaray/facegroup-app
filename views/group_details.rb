# frozen_string_literal: true
require_relative 'posting'

class GroupDetailsView
  SHORT_STR_SIZE = 80
  FB_ATTACHED_URL_PREFIX = 'https://www.facebook.com/l.php?u='
  PLACEHOLDER_IMG_URL = 'http://placehold.it/100x100?text=G'

  attr_reader :group_name, :group_url, :postings

  def initialize(group_details)
    @postings = format_all_postings(group_details.postings)
  end

  private

  def format_all_postings(postings)
    new_postings = postings.map do |posting|
      formatted_posting(posting)
    end
  end

  def formatted_posting(posting)
    short_description = shortened(posting.message, SHORT_STR_SIZE)
    short_attachment = shortened(posting.attachment_description, SHORT_STR_SIZE)
    original_attached_url = original_attachment_url(posting.attachment_url)
    attachment_media_url = posting.attachment_media_url || PLACEHOLDER_IMG_URL

    PostingView.new(
      id = posting.id, created_time = posting.created_time,
      main_description = short_description,
      attachment_title = posting.attachment_title,
      attachment_description = short_attachment,
      attachment_url = original_attached_url,
      attachment_media_url = attachment_media_url
    )
  end

  def original_attachment_url(attachment_url)
    return unless attachment_url
    CGI.unescape(attachment_url.gsub(FB_ATTACHED_URL_PREFIX, ''))
  end

  def shortened(str, size)
    return nil unless str
    str.length < size ? str : str[0..size].gsub(/\s\w+\s*$/,'...')
  end
end
