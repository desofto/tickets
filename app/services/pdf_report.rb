class PdfReport
  PERIOD = 30.days

  def initialize
    @data = stats
  end

  def generate
    WickedPdf.new.pdf_from_string(
      render_to_string('/report.html', layout: nil),
      wkhtmltopdf:  ENV['WKHTMLTOPDF_PATH'],
      margin:       { top: 5, bottom: 25 },
      encoding:     'UTF-8'
    )
  end

  private

  def render_to_string(template, opts = {})
    controller = ApplicationController.new
    controller.instance_variable_set('@data', @data)
    controller.render_to_string(template, opts)
  end

  def stats
    {
      agents: {
        new:    Agent.where('created_at >= ?', PERIOD.ago).count,
        total:  Agent.count,
        requests: agents_requests,
        messages: agents_messages
      },
      requests: {
        opened: Request.where('created_at >= ?', PERIOD.ago).count,
        closed: Request.closed.where('created_at >= ?', PERIOD.ago).count
      }
    }
  end

  def agents_requests
    Agent.joins(:requests).select([:id, :email, 'count(requests.id) as closed']).group(:id).where(requests: { status: Request.statuses['closed'] }).where('requests.updated_at >= ?', PERIOD.ago)
  end

  def agents_messages
    Agent.joins(:messages).select([:id, :email, 'count(messages.id) as messages']).group(:id).where('messages.updated_at >= ?', PERIOD.ago)
  end
end
