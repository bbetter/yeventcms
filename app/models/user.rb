class User < ApplicationRecord
  enum role: { user: 0, dev: 1, analytic: 2, admin: 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_paper_trail

   # Define roles with specific permissions
  ROLE_PERMISSIONS = {
      manage_entities: %i[analytic admin],
      open_event_edit: %i[analytic admin dev],
      manage_releases: %i[dev admin]
  }.freeze

  # Generalized method to check if a user can perform a specific action
  def can?(action)
    ROLE_PERMISSIONS[action.to_sym]&.include?(role.to_sym) || false
  end

  def can_manage_categories?
    can?(:manage_entities)
  end

  def can_add_event?
    can?(:manage_entities)
  end

  def can_manage_event_params?
    can?(:manage_entities)
  end

  def can_delete_event?
    can?(:manage_entities)
  end

  def can_edit_event?
    can?(:manage_entities)
  end

  def can_open_event_edit?
    can?(:open_event_edit)
  end

  def can_manage_releases?
    can?(:manage_releases)
  end

end
