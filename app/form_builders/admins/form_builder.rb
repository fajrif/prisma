# Form builder admin: field Mobility diisi dengan nilai MENTAH bahasa aktif (fallback: false).
# Tanpa ini, admin ID/CN yang kosong menampilkan teks EN (fallback id/cn -> en) lalu menyimpannya
# sebagai teks ID/CN saat form disubmit, dan data bahasa jadi tercemar.
module Admins
  class FormBuilder < SimpleForm::FormBuilder
    def input(attribute_name, options = {}, &block)
      if raw_translated?(attribute_name) && !options.key?(:collection)
        html = (options[:input_html] || {}).dup
        html[:value] = raw_translation(attribute_name) unless html.key?(:value)
        options = options.merge(input_html: html)
      end
      super(attribute_name, options, &block)
    end

    private

    def raw_translated?(attribute_name)
      object.class.respond_to?(:mobility_attributes) &&
        object.class.mobility_attributes.include?(attribute_name.to_s)
    end

    # Rich text (ActionText) tetap objek RichText agar Trix menerima to_trix_html-nya.
    def raw_translation(attribute_name)
      object.public_send(attribute_name, fallback: false)
    end
  end
end
