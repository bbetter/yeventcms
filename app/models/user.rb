class User < ApplicationRecord
  enum role: { user: 0, dev: 1, analytic: 2, admin: 3 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_paper_trail

   # Define roles with specific permissions
   ROLE_PERMISSIONS = {
      manage_events: %i[analytic admin],
      open_edit: %i[analytic admin dev],
      manage_releases: %i[dev, admin]
  }.freeze

  # Generalized method to check if a user can perform a specific action
  def can?(action)
    ROLE_PERMISSIONS[action.to_sym]&.include?(role.to_sym) || false
  end

  # Specific permission methods
  def can_add_event?
    can?(:manage_events)
  end

  def can_delete_event?
    can?(:manage_events)
  end

  def can_edit_event?
    can?(:manage_events)
  end

  def can_manage_event_params?
    can?(:manage_events)
  end

  def can_open_edit?
    can?(:open_edit)
  end

  def can_manage_releases?
    can?(:manage_releases)
  end
end
