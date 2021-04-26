module JobsHelper
  def contact_normalize(contact)
    contact = contact.strip
    unless contact =~ /http/
      'https://t.me/' + contact.gsub('@','')
    end
  end

  def contact_tag(job)
    if job&.contact&.present?
      link = contact_normalize(job.contact)
      if link[0..12] == 'https://t.me/'
        link_to t('show.job.apply_telegram'), link, class: 'btn  btn-primary', role: 'button'
      else
        link_to t('show.job.apply'), job.contact, class: 'btn  btn-primary', role: 'button'
      end
    end
  end

end
