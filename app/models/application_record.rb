# frozen_string_literal: true

# Responsible for the approach makes the features present only for the classes (models) that inherit
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
