class ApplicationMailer < ActionMailer::Base
  after_action :set_process_id_header
  default from: 'from@example.com'
  layout 'mailer'

  def set_process_id_header
    headers['X-SYSTEM-PROCESS-ID'] = Process.pid
  end
end
