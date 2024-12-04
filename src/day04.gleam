import gleam/dict
import gleam/io
import gleam/list
import gleam/result
import gleam/string

fn get_shapes() {
  let right = [#(1, 0), #(2, 0), #(3, 0)]
  let left = [#(-1, 0), #(-2, 0), #(-3, 0)]
  let down = [#(0, 1), #(0, 2), #(0, 3)]
  let up = [#(0, -1), #(0, -2), #(0, -3)]
  let diag_down_right = [#(1, 1), #(2, 2), #(3, 3)]
  let diag_down_left = [#(-1, 1), #(-2, 2), #(-3, 3)]
  let diag_up_right = [#(1, -1), #(2, -2), #(3, -3)]
  let diag_up_left = [#(-1, -1), #(-2, -2), #(-3, -3)]

  [
    right,
    left,
    down,
    up,
    diag_down_right,
    diag_down_left,
    diag_up_right,
    diag_up_left,
  ]
}

pub fn solve_day_part1(input: String) -> Int {
  let coords =
    input
    |> string.split("\n")
    |> list.index_fold([], fn(acc, item, index) {
      let line_coords =
        list.index_fold(string.split(item, ""), [], fn(acc2, item2, index2) {
          [#(#(index2, index), item2), ..acc2]
        })
      [line_coords, ..acc]
    })
    |> list.flatten
    |> dict.from_list

  // find potential start positions
  let x_pos_list =
    coords
    |> dict.filter(fn(_k, v) { v == "X" })

  x_pos_list
  |> dict.keys
  |> list.map(fn(x) { io.debug(x) })
  |> list.fold(0, fn(acc, x_pos) {
    let xmas_count =
      list.map(get_shapes(), fn(shape) { get_letters(x_pos, coords, shape) })
      |> list.count(fn(word) { word == "MAS" })

    acc + xmas_count
  })
}

fn get_letters(location, coords, shape) -> String {
  let #(loc_x, loc_y) = location
  let found_letters =
    shape
    |> list.map(fn(coord) {
      let #(shape_x, shape_y) = coord
      let grid_coord = #(loc_x + shape_x, loc_y + shape_y)
      dict.get(coords, grid_coord) |> result.unwrap("")
    })
    |> string.join("")

  found_letters
}

pub fn solve_day_part2(input: String) -> Int {
  io.println("input:" <> input)
  0
}
