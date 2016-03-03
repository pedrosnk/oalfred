defmodule Oalfred.AgentStore do

  def start_link do
    Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
  end

  def add_user user do
    unless Map.has_key? user, "id" do
      id = :random.uniform() * 1000 |> round() |> Integer.to_string()
      user = Map.update user, "id", id, &(&1)
    end
    Agent.update(__MODULE__, fn users ->
      MapSet.put users, user
    end)
    user
  end

  def update_user user do
    add_user user
  end

  def get_user_by_id id do
    Agent.get(__MODULE__, fn users ->
      Enum.find(users, fn user ->
        user.id == id
      end)
    end)
  end

end
