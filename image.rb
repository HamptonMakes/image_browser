require 'nokogiri'

class Image
  attr :xml_file, true

  def initialize(xml_file)
    @xml_file = xml_file
  end
  
  def self.cache_or_new(xml_file)
    @cache ||= {}
    @cache[xml_file] ||= Image.new(xml_file)
    @cache[xml_file]
  end
  
  def parser
    @parser ||= Nokogiri::XML(open(@xml_file))
  end
  
  def description
    parser.search("DataContent").text.strip
  end
  
  def images
    @images ||= (parser.search("ContentItem[Duid]").to_a.collect do |node|
      node["Href"]
    end).compact
  end
  
  def thumbnail
    (images.select do |filename|
      filename.include?("_1_")
    end).first
  end
end