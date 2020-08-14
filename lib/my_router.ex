defmodule MyRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    msg = """
    <h1>root</h1>
    <h2>Fun Stuff!</h2>
    <ul>
      <li><a href="/visits">Page Visits</a></li>
      <li><a href="/lol">Lol</a></li>
      <li><a href="/persons">List People</a></li>
      <li><a href="/person/dave">Search for Dave</a></li>
      <li><a href="/person/add/dave/12">Add Dave (he is 12)</a></li>
    </ul>
    """
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, msg)
  end

  get "/index" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world from " <> conn.host())
  end

  get "/visits" do
    count = SimpleServerEx.Counter.count()
    send_resp(conn, 404, "<h1>Page has been visited #{count} times.</h1>")
  end

  get "/person/:name" do
    send_resp(conn, 200, SimpleServerEx.Person.person_info(name))
  end

  get "/person/add/:name/:age" do
    send_resp(conn, 200, SimpleServerEx.Person.add_person(name, age))
  end

  get "/persons" do
    send_resp(conn, 200, SimpleServerEx.Person.persons())
  end

  get "/lol" do
    chonk = fn (chunk, conn) -> case Plug.Conn.chunk(conn, chunk) do
        {:ok, conn} ->
         {:cont, conn}
        {:error, :closed} ->
          {:halt, conn}
      end
    end
    newcon = Plug.Conn.send_chunked(conn, 200)
    Enum.reduce_while(Stream.cycle(["l","o"]), newcon, chonk)
  end

  match _ do
    send_resp(conn, 404, "404 not found")
  end
end
