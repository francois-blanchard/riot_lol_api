require 'active_support/inflector'

module CoreExt
  module Hash
    module RiotLolApi

      def lol_symbolize
        new_hash = {}
        each do |k, v|
          if v.is_a? Array
            populate_new_hash_from_array(new_hash: new_hash, key: k, values: v)
          elsif v.is_a? ::Hash
            new_hash[k.lol_symbolize] = initalize_lol_object(name_class: classify(k), values: v)
          else
            new_hash[k.lol_symbolize] = v
          end
        end
        new_hash
      end

      private

      def populate_new_hash_from_array(new_hash:, key:, values:)
        key_sym = key.lol_symbolize
        new_hash[key_sym] = []
        return populate_new_hash_with_lol_object(new_hash: new_hash, key: key, values: values) if values.first.is_a? ::Hash
        values.each do |tab|
          new_hash[key_sym] << tab
        end
      end

      def populate_new_hash_with_lol_object(new_hash:, key:, values:)
        name_class = classify key
        values.each do |tab|
          new_hash[key.lol_symbolize] << initalize_lol_object(name_class: name_class, values: tab)
        end
      end

      def initalize_lol_object(name_class:, values:)
        Object.const_get("::RiotLolApi::Model::#{name_class}").new(values.lol_symbolize)
      end

      def classify(name)
        name.singularize.camelize
      end

    end
  end
end
