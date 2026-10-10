class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Lampiran yang wajib ada (validates ..., attached: true) tidak boleh dihapus dari admin:
  # record jadi tidak valid dan tidak bisa disimpan lagi.
  def attachment_required?(name)
    self.class.validators_on(name.to_sym).any? { |v| v.is_a?(ActiveStorageValidations::AttachedValidator) }
  end
end
