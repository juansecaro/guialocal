# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.guia#{ENV['CURRENT_CITY']}.es"

SitemapGenerator::Sitemap.create do

  add '/mapas', :priority => 1, :changefreq => 'yearly'
  add '/mercadillo-digital', :priority => 1, :changefreq => 'yearly'
  add '/ofertas_y_promociones', :priority => 1, :changefreq => 'daily'
  add '/empresas-ordenadas', :priority => 0.5, :changefreq => 'never'
  add '/empresas-ordenadas', :priority => 0.5, :changefreq => 'never'
  add '/historia', :priority => 1, :changefreq => 'yearly'
  add '/turismo', :priority => 1, :changefreq => 'yearly'
  add '/alojamiento', :priority => 1, :changefreq => 'yearly'
  add '/naturaleza', :priority => 1, :changefreq => 'yearly'
  add '/ocio', :priority => 1, :changefreq => 'yearly'
  add '/publicitate', :priority => 1, :changefreq => 'yearly'
  add '/politicadeprivacidad', :priority => 0.5, :changefreq => 'yearly'
  add '/cookies', :priority => 0.5, :changefreq => 'yearly'
  add '/condicionesdeuso', :priority => 0.5, :changefreq => 'yearly'
  add '/preguntasfrecuentes', :priority => 0.5, :changefreq => 'yearly'
  add '/quejasysugerencias', :priority => 0.5, :changefreq => 'yearly'
  add '/agradecimientos', :priority => 0.5, :changefreq => 'yearly'
  add '/contacts/new', :priority => 0.5, :changefreq => 'yearly'

  add empresas_path, :priority => 0.5, :changefreq => 'weekly'
  Empresa.find_each do |empresa|
    add empresa_path(empresa), :lastmod => empresa.updated_at, :priority => 0.5
  end

  add categories_path, :priority => 0.5, :changefreq => 'weekly'
  Category.find_each do |cat|
    add category_path(cat), :lastmod => cat.updated_at, :priority => 0.5
  end

  add tags_path, :priority => 0.5, :changefreq => 'weekly'
  Tag.find_each do |tag|
    add tag_path(tag), :lastmod => tag.updated_at, :priority => 0.5
  end
  add eventos_path, :priority => 0.5, :changefreq => 'weekly'

end
