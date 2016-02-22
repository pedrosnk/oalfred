defmodule Oalfred.AgentStore do

  def start_link do
    Agent.start_link(fn -> MapSet.new end, name: __MODULE__)
  end

  def add_user user do
    Agent.update(__MODULE__, fn users ->
      MapSet.put users, user
    end)
  end

  def get_user_by_id id do
    Agent.get(__MODULE__, fn users ->
      Enum.find(users, fn user ->
        user.id == id 
      end)
    end)
  end

end
