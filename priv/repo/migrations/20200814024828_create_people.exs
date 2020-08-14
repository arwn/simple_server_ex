defmodule SimpleServerEx.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :age, :integer
    end
  end
end
