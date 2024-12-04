import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

fn get_sorted_lists(input) {
  let #(list_left, list_right) =
    input
    |> string.split("\n")
    |> list.map(extract_numbers)
    |> list.unzip

  let sorted_list_left = list_left |> list.sort(by: int.compare)
  let sorted_list_right = list_right |> list.sort(by: int.compare)

  #(sorted_list_left, sorted_list_right)
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

pub fn solve_day_part1(input: String) {
  io.println(input)
  let #(left_nums, right_nums) = get_sorted_lists(input)

  let total_distance =
    list.zip(left_nums, right_nums)
    |> list.fold(0, fn(acc, pair) {
      let #(left, right) = pair
      acc + int.absolute_value(left - right)
    })

  total_distance
}

pub fn solve_day_part2(input: String) {
  let #(left_nums, right_nums) = get_sorted_lists(input)

  let similarity =
    list.fold(left_nums, 0, fn(acc, left) {
      acc + left * list.count(right_nums, fn(right) { right == left })
    })

  similarity
}
