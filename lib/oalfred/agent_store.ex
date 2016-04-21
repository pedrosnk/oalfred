defmodule Oalfred.AgentStore do

  def start_link do
    Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
  end

  def add_user user do
    user = add_id_to_user user
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

  def destroy_user_by_id id do
    deleted_user = false
    Agent.update(__MODULE__, fn users ->
      user = Enum.find(users, fn user ->
        user.id == id
      end)
      deleted_user = true
      MapSet.delete users, user
    end)
    deleted_user
  end

  defp add_id_to_user user do
    case Map.has_key? user, "id" do
      true -> user
      false ->
        id = :random.uniform() * 1000 |> round() |> Integer.to_string()
        Map.update user, "id", id, &(&1)
    end
  end

end
