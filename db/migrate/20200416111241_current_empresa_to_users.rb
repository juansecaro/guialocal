# frozen_string_literal: true

class CurrentEmpresaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_empresa, :integer, default: nil
  end
end
