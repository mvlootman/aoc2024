import gleam/int
import gleam/list
import gleam/string

pub fn solve_day_part1(input: String) -> Int {
  parse_input(input)
  |> list.map(is_safe_report)
  |> list.count(fn(safe) { safe })
}

pub fn solve_day_part2(input: String) {
  parse_input(input)
  |> list.filter(filter_safe_report)
  |> list.length
}

fn parse_input(input) {
  input
  |> string.trim
  |> string.split("\n")
  |> list.map(extract_numbers)
}

// report_variants returns each combination with 1 number removed
fn report_variants(report: List(Int)) -> List(List(Int)) {
  let n = list.length(report)
  list.combinations(report, n - 1)
}

fn filter_safe_report(report: List(Int)) -> Bool {
  list.any([report, ..report_variants(report)], is_safe_report)
}

fn is_safe_report(numbers: List(Int)) -> Bool {
  let pairs = numbers |> list.window_by_2

  let assert [fst, snd, ..] = numbers
  let all_ascending = fst < snd

  let safe_ordering =
    pairs
    |> list.all(fn(pair) {
      let #(l, r) = pair
      case all_ascending {
        True -> l < r
        False -> l > r
      }
    })

  let safe_inc_decr =
    pairs
    |> list.all(fn(pair) {
      let #(l, r) = pair
      int.absolute_value(l - r) < 4
    })

  safe_ordering && safe_inc_decr
}

fn extract_numbers(line: String) -> List(Int) {
  string.split(line, on: " ")
  |> list.map(fn(s) {
    let assert Ok(num) = int.parse(s)
    num
  })
}
