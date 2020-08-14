defmodule SimpleServerEx.Person do
  use Ecto.Schema
  require Ecto.Query

  schema "people" do
    field :name, :string
    field :age, :integer
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:name, :age])
    |> Ecto.Changeset.validate_required([:name, :age])
  end

  def add_person(name, age) do
    {age_num, _} = Integer.parse(age)
    %SimpleServerEx.Person{name: name, age: age_num}
    |> SimpleServerEx.Repo.insert
    "ok"
  end

  def persons() do
    Ecto.Query.from(p in SimpleServerEx.Person)
    |> SimpleServerEx.Repo.all
    |> Enum.map_join(&("#{&1.name} #{&1.age}\n"))
  end

  @doc """
  Queries the database for a person.
  """
  def person_info(name) do
    Ecto.Query.from(p in SimpleServerEx.Person, where: p.name == ^name)
    |> SimpleServerEx.Repo.all
    |> Enum.map_join(&("#{&1.name} #{&1.age}\n"))
  end
end
