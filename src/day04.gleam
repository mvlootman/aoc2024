import gleam/dict
import gleam/list
import gleam/result
import gleam/string

pub fn solve_day_part1(input: String) -> Int {
  let coords = get_coords_dict(input)

  // find potential start positions
  let x_loc_list = get_start_pos(coords, "X")

  x_loc_list
  |> dict.keys
  |> list.fold(0, fn(acc, x_pos) {
    let xmas_count =
      list.map(get_part1_shapes(), fn(shape) {
        get_letters(x_pos, coords, shape)
      })
      |> list.count(fn(word) { word == "MAS" })

    acc + xmas_count
  })
}

pub fn solve_day_part2(input: String) -> Int {
  let coords = get_coords_dict(input)

  // find potential start positions
  let a_loc_list = get_start_pos(coords, "A")

  a_loc_list
  |> dict.keys
  |> list.fold(0, fn(acc, x_pos) {
    let xmas_count =
      list.map(get_part2_shapes(), fn(shape) {
        get_letters(x_pos, coords, shape)
      })
      |> list.count(fn(word) {
        list.contains(["MSMS", "SMSM", "MSSM", "SMMS"], word)
      })

    acc + xmas_count
  })
}

fn get_start_pos(coords, letter) {
  coords
  |> dict.filter(fn(_k, v) { v == letter })
}

fn get_part1_shapes() {
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

fn get_part2_shapes() {
  // x-wise
  [[#(-1, -1), #(1, 1), #(-1, 1), #(1, -1)]]
}

fn get_coords_dict(input) -> dict.Dict(#(Int, Int), String) {
  // input
  // |> string.split("\n")
  // |> list.index_fold([], fn(acc, item, index) {
  //   let line_coords =
  //     list.index_fold(string.split(item, ""), [], fn(acc2, item2, index2) {
  //       [#(#(index2, index), item2), ..acc2]
  //     })
  //   [line_coords, ..acc]
  // })
  // |> list.flatten
  // |> dict.from_list

  let lines = string.split(input, "\n")
  use coords, line, line_idx <- list.index_fold(lines, dict.new())
  use coords, char, col_idx <- list.index_fold(string.split(line, ""), coords)

  dict.insert(coords, #(col_idx, line_idx), char)
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
