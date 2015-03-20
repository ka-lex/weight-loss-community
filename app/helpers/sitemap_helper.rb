module SitemapHelper

  def set_url xml, uri
    xml.url do
      xml.loc "http://www.nimmt-ab.de/" + uri
      xml.lastmod     Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq  "monthly"
      xml.priority "0.6"
    end
  end

end
