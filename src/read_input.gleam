import gleam/erlang
import gleam/list

// read_lines_stdin reads from stdin lines until eoff
pub fn read_lines_stdin() -> List(String) {
  do_read_line([""])
  |> list.reverse
}

fn do_read_line(buffer) {
  let line_in = erlang.get_line("")

  case line_in {
    Ok(input) -> do_read_line([input, ..buffer])
    Error(_) -> buffer
  }
}
