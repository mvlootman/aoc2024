import gleam/int
import gleam/list
import gleam/option.{Some}
import gleam/pair
import gleam/regexp
import gleam/result
import gleam/string

pub fn solve_day_part1(input: String) -> Int {
  parse_input(input)
  |> list.map(fn(instr) {
    let #(a, b) = instr
    a * b
  })
  |> int.sum
}

fn parse_input(input) {
  let assert Ok(pattern) =
    regexp.from_string("mul\\((?<a>\\d{1,3}),(?<b>\\d{1,3})\\)")

  input
  |> string.trim
  |> regexp.scan(pattern, _)
  |> list.map(fn(m: regexp.Match) {
    let assert [a, b] = option.values(m.submatches)
    let a = a |> int.parse |> result.unwrap(0)
    let b = b |> int.parse |> result.unwrap(0)

    #(a, b)
  })
}

pub fn solve_day_part2(input: String) {
  // regex on all the instructions (mul/don't/do)
  let assert Ok(re) =
    regexp.from_string("mul\\((\\d+),(\\d+)\\)|don't\\(\\)|do\\(\\)")

  // get all matches and count mul
  // state tracks total and if we are in active state
  regexp.scan(re, input)
  |> list.fold(#(0, True), fn(state, match) {
    case match, state {
      regexp.Match(_, [Some(x), Some(y)]), #(sum, True) -> {
        let assert Ok(x) = x |> int.parse
        let assert Ok(y) = y |> int.parse
        #(sum + x * y, True)
      }

      regexp.Match("don't()", _), #(sum, _) -> {
        // keep total and disable active state
        #(sum, False)
      }

      regexp.Match("do()", _), #(sum, _) -> {
        // keep total and set active state
        #(sum, True)
      }
      _, _ -> state
    }
  })
  |> pair.first
}
