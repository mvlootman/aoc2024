import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Operator {
  Add
  Multiply
  Concat
}

pub fn solve_day_part1(input: String) -> Int {
  let lines = parse_input(input)

  let operators = [Add, Multiply]
  solve(lines, operators)
}

pub fn solve_day_part2(input: String) -> Int {
  let lines = parse_input(input)

  let operators = [Add, Multiply, Concat]
  solve(lines, operators)
}

fn solve(lines, operators_to_use) {
  lines
  |> list.fold(0, fn(acc, line) {
    let assert [res, ..numbers] = line

    case solve_equation(res, numbers, operators_to_use) {
      True -> acc + res
      False -> acc
    }
  })
}

fn parse_input(input: String) -> List(List(Int)) {
  input
  |> string.trim
  |> string.replace(":", "")
  |> string.split("\n")
  |> list.map(fn(line) {
    string.split(line, " ")
    |> list.map(fn(x) { int.parse(x) |> result.unwrap(0) })
  })
}

fn solve_equation(result: Int, numbers: List(Int), operators: List(Operator)) {
  case numbers {
    // base case
    [x] if x == result -> True
    [_] -> False
    [x, y, ..rest] -> {
      list.fold_until(operators, False, fn(acc, operator) {
        let op_fn = case operator {
          Add -> int.add
          Multiply -> int.multiply
          Concat -> fn(a, b) {
            int.parse(a |> int.to_string <> b |> int.to_string)
            |> result.unwrap(0)
          }
        }
        // recurse
        case solve_equation(result, [op_fn(x, y), ..rest], operators) {
          True -> list.Stop(True)
          False -> list.Continue(acc)
        }
      })
    }
    _ -> False
  }
}
