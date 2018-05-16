module Jekyll
  module CollectionsTaxonomy
    PLUGIN_NAME = "collection-indexer"
    LAYOUT_NAME = "collection-index"

    class CollectionTaxonomyPageGenerator < Generator
      safe true

      def generate(site)
        puts("Running plugin `#{PLUGIN_NAME}` generate(site) method")
        if site.layouts.key? LAYOUT_NAME
          puts("site.layouts.#{LAYOUT_NAME} exists, all good")
          dir = site.config['taxonomy_dir'] || 'taxonomies'

          site.collections.each_key do |collection|
            puts("Plugin #{PLUGIN_NAME} processing collection `#{collection}`")
          end

          site.categories.each_key do |cat|
            cat_slug = Utils.slugify(cat)
            site.pages << CollectionTaxonomyPage.new(site, site.source, File.join(dir, cat_slug), cat_slug)
          end
        else
          puts("site.layouts.#{LAYOUT_NAME} doesn't exist, not running the plugin")
        end
      end
    end

    class CollectionTaxonomyPage < Page
      def initialize(site, base, dir, category)
        puts("Running plugin #{PLUGIN_NAME} initialize(site, base, dir, category) method.\n" +
          "   site=#{site}, base=#{base}, dir=#{dir}, category=#{category}")
        @site = site
        @base = base
        @dir = dir
        @name = 'index.html'

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), "#{LAYOUT_NAME}.html")
        self.data['category'] = category

        category_title_prefix = site.config['category_title_prefix'] || "#{category} Category: "
        self.data['title'] = "#{category_title_prefix}#{category}-yohoho"
      end
    end

  end
end
