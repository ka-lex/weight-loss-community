xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:mobile" => "http://www.google.com/schemas/sitemap-mobile/1.0" do
  xml.url do
    xml.loc         "http://m.soprico.com/"
    xml.lastmod     Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq  "always"
    xml.mobile:mobile
  end

  xml.url do
    xml.loc "http://m.soprico.com/top-100-viewed"
    xml.lastmod     Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq  "daily"
    xml.mobile:mobile
  end

  @entries.each do |entry|
    xml.url do
      xml.loc "http://m.soprico.com" + url_for(entry)
      xml.lastmod entry.updated_at.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq  "daily"
      xml.priority    0.9
      xml.mobile:mobile
    end
  end
end