module SpreeMobility
  module Translatable
    extend ActiveSupport::Concern

    include Spree::RansackableAttributes

    included do |klass|
      klass.send :extend, Mobility
      has_many :translations
      accepts_nested_attributes_for :translations
      klass.whitelisted_ransackable_associations ||= []
      klass.whitelisted_ransackable_associations |= ['translations']
    end

    class_methods do
      def translation_class
        const_get('Translation')
      end
      
      def ransack(params = {}, options = {})
        params ||= {}
        names = params.keys
        params[:translations_locale_eq] ||= I18n.locale.to_s

        names.each do |n|
          translated_attribute_names.each do |t|
            if n.to_s.starts_with? t.to_s
              params[:"translations_#{n}"] = params[n]
              params.delete n
            end
          end
        end

        super(params, options)
      end
      alias :search :ransack unless respond_to? :search

      # preload translations
      def spree_base_scopes
        super.with_translations
      end
    end
  end
end
