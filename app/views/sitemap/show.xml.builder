xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:image" => "http://www.google.com/schemas/sitemap-image/1.1" do
  xml.url do
    xml.loc         "http://www.nimmt-ab.de/"
    xml.lastmod     Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    xml.changefreq  "daily"
  end  

  set_url xml, "tour"
  set_url xml, "tour/gewichtstagebuch"
  set_url xml, "tour/unterstuetzer"
  set_url xml, "tour/ziele"
  set_url xml, "tour/profil"

  @users.each do |user|
    xml.url do
      xml.loc         "http://www.nimmt-ab.de/accounts/#{user.slug}"
      xml.lastmod     Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")
      xml.changefreq  "daily"
    end  
  end
    
end
