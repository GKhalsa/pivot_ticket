module ImageGetter

  def get_image(search_string, index)
    getter = Faraday.new
    getter.headers["Api-key"] = ENV['GETTY_IMAGES_KEY']
    response = getter.get("https://api.gettyimages.com/v3/search/images/creative?phrase=#{search_string}")
    raw_data = response.body
    data = JSON.parse(raw_data, object_class: OpenStruct)
    data.images[index % 30].display_sizes.first.uri
  end

end
