module PurchasesHelper
  def purchases_title
    if purchases_active_page === :purchase
      content_tag :h3, "購入中の商品", class: "purchases__title"
    elsif purchases_active_page === :purchased
      content_tag :h3, "購入済みの商品", class: "purchases__title"
    end
  end

  def purchases_list
    [:purchase, :purchased].each do |type|
        concat (
          content_tag :li, class: "purchases__content__list__title #{ 'active' if purchases_active_page === type || ( type === :purchase && current_page?(user_path(current_user)) ) }" do
            concat link_to purchases_item_tag(type), eval("#{type}_user_path(current_user)")
          end
        )
    end
  end

  def purchases_active_item_tag
    purchases_item_tag(purchases_active_page)
  end

  def purchases_active_page
    if request.url === purchase_user_url(current_user)
      :purchase
    elsif request.url === purchased_user_url(current_user)
      :purchased
    end
  end

  private

  def purchases_item_tag(type)
    case type
    when :purchase
      "取引中"
    when :purchased
      "過去の取引"
    end
  end
end