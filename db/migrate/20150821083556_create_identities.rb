class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.string :oauth_expires_at

      t.timestamps null: false
    end
  end
end
