class SearchController < ApplicationController

  def index
		unless params[:search].blank?
			criteria = Page.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
		end

		@pages = criteria

		unless params[:search].blank?
			criteria = Article.joins(:action_text_rich_text).where("title ->> :key ILIKE :value OR (action_text_rich_texts.locale = :key AND action_text_rich_texts.body ILIKE :value)", key: I18n.locale.to_s, value: "%#{params[:search]}%").uniq
		end

		@articles = criteria

    respond_to do |format|
      format.html
      format.js
    end
  end

end
