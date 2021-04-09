class RebuildJob < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :salary, :string
    add_column :jobs, :salary_min, :integer
    add_column :jobs, :salary_max, :integer
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON jobs
    SQL

    execute <<-SQL
      CREATE OR REPLACE FUNCTION jobs_trigger() RETURNS trigger AS $$
      begin
        new.fts :=
            setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
            setweight(to_tsvector('pg_catalog.english', coalesce(new.description,'')), 'D');
        return new;
      end
      $$ LANGUAGE plpgsql;
      CREATE TRIGGER tsvectorupdate before INSERT OR UPDATE
      ON jobs FOR EACH ROW EXECUTE PROCEDURE jobs_trigger();

    SQL

  end
end
