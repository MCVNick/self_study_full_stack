defmodule Backend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string, unique: true)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:password_confermation, :string, virtual: true)
    field(:role, :string, default: "user")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :password_confermation, :role])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confermation,
      :role
    ])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 60)
    |> validate_confermation(:password)
    |> unique_constraint(:email)

    # |> hash_password
  end

  # defp hash_password(changeset) do
  #   changeset
  # end
end
