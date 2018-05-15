module Jekyll
  COLLECTION_TAXONOMY_LAYOUT_BASE_NAME = "collection-index"

  class CollectionTaxonomyPage < Page
    def initialize(site, base, dir, category)
      puts("Running collection-indexer-plugin.rb initialize(site, base, dir, category) method.\n" +
        "   category=#{category}, base=#{base}, dir=#{dir}")
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), "#{COLLECTION_TAXONOMY_LAYOUT_BASE_NAME}.html")
      self.data['category'] = category

      category_title_prefix = site.config['category_title_prefix'] || "#{category} Category: "
      self.data['title'] = "#{category_title_prefix}#{category}-yohoho"
    end
  end

  class CollectionTaxonomyPageGenerator < Generator
    safe true

    def generate(site)
      puts("Running collection-indexer-plugin.rb generate(site) method")
      if site.layouts.key? COLLECTION_TAXONOMY_LAYOUT_BASE_NAME
        puts("site.layouts.key == true")
        dir = site.config['category_dir'] || 'categories'
        site.categories.each_key do |category|
          site.pages << CollectionTaxonomyPage.new(site, site.source, File.join(dir, category), category)
        end
      else
        puts("site.layouts.key == false")
      end
    end
  end
end
