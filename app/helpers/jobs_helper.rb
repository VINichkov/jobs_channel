module JobsHelper
  def contact_normalize(contact)
    if contact.host.nil?
      contact.host = 't.me'
      contact.scheme = 'https'
      contact.path = contact.path.gsub('@','')
    end
    contact
  end

  def contact_tag(job)
    if job&.contact&.present?
      link = contact_normalize( URI( job.contact ) )
      if link.host == 't.me'
        link_to t('show.job.apply_telegram'), link.to_s, class: 'btn  btn-primary', role: 'button'
      else
        link_to t('show.job.apply'), job.contact, class: 'btn  btn-primary', role: 'button'
      end
    end
  end

end
