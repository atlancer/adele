class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :layout_for_page

  # todo add cache

  private

  def layout_for_page
    case params[:id]
      when 'contacts'
        'porto'
      else
        'application'
    end
  end
end
