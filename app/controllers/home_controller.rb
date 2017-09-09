# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        render file: '/public/index.html'
      end
    end
  end

  def report
    respond_to do |format|
      format.pdf do
        context = { filename: 'report.pdf', type: 'application/pdf', disposition: 'inline' }#'attachment' }

        pdf = PdfReport.new.generate

        send_data pdf, context
      end
    end
  end
end
