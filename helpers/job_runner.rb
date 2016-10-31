require 'rufus-scheduler'
job = Thread.new do
  scheduler = Rufus::Scheduler.new
  scheduler.every '60s' do
    @message = Messages.all(:deleted_at.not => nil)
    if @message.any?
      @message.each do |item|
        if item.deleted_at.to_datetime <= DateTime.now
          Messages.first(:uuid => item.uuid).destroy
        end
      end
    end
    scheduler.join
  end
end
job.join()