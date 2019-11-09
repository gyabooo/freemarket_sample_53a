module HeaderGuideHelper
  # ドロップダウンリストヘルパー（ancestryのみ対応）
  def ddmenu_list(roots, index = nil)
    unless index
      index = 1
    else
      index += 1
    end

    category_roots(roots, index).each do |id, name, root|
      concat (
        content_tag(:li) do
          concat link_to name, url_for(root), class: 'ddmenu--category_link'
          if root.has_children?
            concat (
              content_tag(:ul, class: "ddmenu--#{index}-level") do
                ddmenu_list(root.children.limit(roots.count), index)
              end
            )
          end
        end
      )
    end
  end

  private

  def category_roots(roots, index)
    Rails.cache.fetch("root/#{roots.model_name.name}/#{index}", expired_in: 1.days.to_i) do
      category_pluck = roots.pluck(:id, :name, :ancestry)
      Array(roots).map.with_index {|root, i| category_pluck[i].push(root)}
    end
  end
end