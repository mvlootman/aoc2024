import gleam/dict
import gleam/list
import gleam/result
import gleam/set
import gleam/string

type Coord {
  Coord(x: Int, y: Int)
}

type MapType {
  Guard
  Empty
  Obstacle
}

type Direction {
  Up
  Down
  Left
  Right
}

pub fn solve_day_part1(input: String) -> Int {
  let lines =
    input
    |> string.split("\n")

  let max_x = list.first(lines) |> result.unwrap("") |> string.length
  let max_y = list.length(lines)

  let map =
    lines
    |> list.index_fold(dict.new(), fn(acc, line, line_idx) {
      list.index_fold(
        string.to_graphemes(line),
        dict.new(),
        fn(acc2, cell, cell_idx) {
          let map_type = case cell {
            "." -> Empty
            "#" -> Obstacle
            "^" -> Guard
            _ -> Empty
          }
          // how to extract the Guard location while parsing??? (struct with coords and guard_pos field?)
          // now maps also empty could be left out
          dict.insert(acc2, Coord(cell_idx, line_idx), map_type)
        },
      )
      |> dict.merge(acc)
    })

  let guard_pos =
    dict.filter(map, fn(_k, v) { v == Guard })
    |> dict.keys
    |> list.first
    |> result.unwrap(Coord(-1, -1))

  let #(_last_pos, _last_dir, visit_count) =
    traverse(map, guard_pos, Up, set.new(), max_x, max_y)

  visit_count
}

fn traverse(
  map: dict.Dict(Coord, MapType),
  position: Coord,
  direction: Direction,
  visited: set.Set(Coord),
  max_x: Int,
  max_y: Int,
) -> #(Coord, Direction, Int) {
  let visited = set.insert(visited, position)

  let candidate_pos = case direction {
    Down -> Coord(position.x, position.y + 1)
    Left -> Coord(position.x - 1, position.y)
    Right -> Coord(position.x + 1, position.y)
    Up -> Coord(position.x, position.y - 1)
  }

  let new_pos = case dict.get(map, candidate_pos) {
    Ok(Obstacle) -> {
      let new_dir = case direction {
        Up -> Right
        Right -> Down
        Down -> Left
        Left -> Up
      }
      // retry with same position but turned direction
      #(position, new_dir, set.size(visited))
    }
    _ -> #(candidate_pos, direction, set.size(visited))
  }

  let #(pos, new_dir, _visit_count) = new_pos
  // check if we exited the map otherwise recurse
  case pos.x >= max_x, pos.y >= max_y {
    True, _ -> new_pos
    _, True -> new_pos
    _, _ -> traverse(map, pos, new_dir, visited, max_x, max_y)
  }
}
