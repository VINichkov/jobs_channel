class CreateJobs < ActiveRecord::Migration[6.1]
  def up
    create_table :jobs do |t|
      t.string :title, null: false
      t.string :company_name
      t.string :company_link
      t.boolean :remote, default: false
      t.string :type
      t.string :location
      t.string :salary
      t.string :source
      t.string :contract
      t.string :aasm_state
      t.text :description
      t.jsonb :tags, array: true, default: []
      t.tsvector :fts
      t.index :fts, using: "gin"

      t.timestamps
    end

    execute <<-SQL
      CREATE FUNCTION jobs_trigger() RETURNS trigger AS $$
      begin
        new.fts :=
            setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.location,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.company_name,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.type,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.salary,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.description,'')), 'D');
        return new;
      end
      $$ LANGUAGE plpgsql;
      CREATE TRIGGER tsvectorupdate before INSERT OR UPDATE
      ON jobs FOR EACH ROW EXECUTE PROCEDURE jobs_trigger();

    SQL

  end
end
