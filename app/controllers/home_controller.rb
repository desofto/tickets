# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        render file: '/public/index.html'
      end
    end
  end
end
