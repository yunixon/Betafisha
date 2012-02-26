module SiteNavigationHelper

  # Return a title on a per-page basis.
  def title ( title )
    base_title = title
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
