module Jekyll
  module CollectionsTaxonomy
    PLUGIN_NAME = "collection-indexer"
    LAYOUT_NAME = "collection-index"

    class CollectionTaxonomyPageGenerator < Generator
      safe true

      def generate(site)
        puts("Running plugin `#{PLUGIN_NAME}` generate() method")
        if site.layouts.key? LAYOUT_NAME
          puts("site.layouts.#{LAYOUT_NAME} exists, all good")
          dir = site.config['taxonomy_dir'] || 'taxonomies'

          site.collections.each do |col_name, col_data|
            puts("Plugin #{PLUGIN_NAME} processing collection `#{col_name}`, label `#{col_data.label}`")
            if (col_name == "posts")
              puts("Skipping `posts` collection")
              next
            end
            col_slug = Utils.slugify(col_name)
            # site.pages << CollectionTaxonomyPage.new(site, site.source, File.join(dir, col_slug), col, )
            col_data.docs.each do |doc|
              puts("====================")
              puts doc.data
              puts("--------------------")
              puts doc
              puts("====================")
            end
          end

          # site.categories.each_key do |cat|
          #   cat_slug = Utils.slugify(cat)
          #   site.pages << CollectionTaxonomyPage.new(site, site.source, File.join(dir, cat_slug), cat_slug)
          # end
        else
          puts("site.layouts.#{LAYOUT_NAME} doesn't exist, not running plugin `#{PLUGIN_NAME}`")
        end
      end
    end

    class CollectionTaxonomyPage < Page
      def initialize(site, base, dir, collection, tax_name, tax_slug)
        puts("Running plugin #{PLUGIN_NAME} initialize() method.\n" +
          "   site=#{site}, base=#{base}, dir=#{dir}, category=#{category}")
        @site = site
        @base = base
        @dir = dir
        @name = 'index.html'

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), "#{LAYOUT_NAME}.html")
        self.data['category'] = tax_name

        self.data['title'] = "Col: #{collection}, Tax_name: #{tax_name}, slug: #{tax_slug}"
      end
    end

    class String
      def titlecase
        split(/([[:alpha:]]+)/).map(&:capitalize).join
      end
    end

  end
end
