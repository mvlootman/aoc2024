import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

fn get_sorted_lists(input) {
  let pairs =
    input
    |> string.split("\n")
    |> list.map(extract_numbers)

  let left_nums =
    list.map(pairs, fn(pair) { pair.0 })
    |> list.sort(by: int.compare)

  let right_nums =
    list.map(pairs, fn(pair) { pair.1 })
    |> list.sort(by: int.compare)

  #(left_nums, right_nums)
}

fn extract_numbers(line: String) -> #(Int, Int) {
  let assert Ok(expr) = regexp.from_string("([0-9]*) ([0-9]*)")

  let matches = regexp.scan(expr, line)
  let assert Ok(left_str) = list.first(matches)
  let assert Ok(right_str) = list.last(matches)
  let left_num =
    left_str.content |> string.trim |> int.parse |> result.unwrap(0)
  let right_num =
    right_str.content |> string.trim |> int.parse |> result.unwrap(0)

  #(left_num, right_num)
}

pub fn solve_day_01a(input: String) {
  let #(left_nums, right_nums) = get_sorted_lists(input)

  let total_distance =
    list.zip(left_nums, right_nums)
    |> list.fold(0, fn(acc, pair) {
      let #(left, right) = pair
      acc + int.absolute_value(left - right)
    })

  io.println("Day 1 part 1:" <> total_distance |> int.to_string)
}

pub fn solve_day_01b(input: String) {
  let #(left_nums, right_nums) = get_sorted_lists(input)

  let similarity =
    list.fold(left_nums, 0, fn(acc, n) {
      acc + n * list.count(right_nums, fn(x) { x == n })
    })

  io.println("Day 1 part 2:" <> similarity |> int.to_string)
}
