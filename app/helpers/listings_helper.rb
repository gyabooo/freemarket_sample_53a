module ListingsHelper
  def listings_title
    if listings_active_page.include?('listing')
      content_tag :h3, "出品した商品", class: "listings__title"
    elsif listings_active_page.include?('in_progress')
      content_tag :h3, "取引中の商品", class: "listings__title"
    elsif listings_active_page.include?('completed')
      content_tag :h3, "売却済みの商品", class: "listings__title"
    end
  end

  def listings_list
    ['listing', 'in_progress', 'completed'].each do |type|
        concat (
          content_tag :li, class: "listings__content__list__title #{ 'active' if listings_active_page.include?(type) }" do
            concat link_to ilistings_item_tag(type), eval("#{type}_user_path(current_user)")
          end
        )
    end
  end

  def listings_active_item_tag
    ilistings_item_tag(listings_active_page)
  end

  def listings_active_page
    if request.url.include?(listing_user_url(current_user))
      'listing'
    elsif request.url.include?(in_progress_user_url(current_user))
      'in_progress'
    elsif request.url.include?(completed_user_url(current_user))
      'completed'
    end
  end

  private

  def ilistings_item_tag(type)
    case type
    when 'listing'
      "出品中"
    when 'in_progress'
      "取引中"
    when 'completed'
      "売却済み"
    end
  end
end