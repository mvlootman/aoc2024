import argv
import day01
import day02
import day03
import day04
import day05
import day06
import day07
import gleam/int
import gleam/io
import gleam/result
import gleam/string
import read_input.{read_lines_stdin}

pub fn main() {
  io.println("Advent of code 2024!")

  let input = read_lines_stdin() |> string.join("") |> string.trim

  case argv.load().arguments {
    [day] -> {
      let day = day |> int.parse |> result.unwrap(0)
      case day {
        1 -> run_day01(day, input)
        2 -> run_day02(day, input)
        3 -> run_day03(day, input)
        4 -> run_day04(day, input)
        5 -> run_day05(day, input)
        6 -> run_day06(day, input)
        7 -> run_day07(day, input)
        _ -> io.println("not completed yet!")
      }
    }
    _ -> io.println("Provide a day number to run")
  }
}

fn run_day07(day, input) {
  let p1 = day07.solve_day_part1(input)
  let p2 = day07.solve_day_part2(input)

  report(day, p1, p2)
}
fn run_day06(day, input) {
  let p1 = day06.solve_day_part1(input)
  let p2 = -1
  //day06.solve_day_part2(input)

  report(day, p1, p2)
}

fn run_day05(day, input) {
  let p1 = day05.solve_day_part1(input)
  let p2 = day05.solve_day_part2(input)

  report(day, p1, p2)
}

fn run_day04(day, input) {
  let p1 = day04.solve_day_part1(input)
  let p2 = day04.solve_day_part2(input)

  report(day, p1, p2)
}

fn run_day03(day, input) {
  let p1 = day03.solve_day_part1(input)
  let p2 = day03.solve_day_part2(input)

  report(day, p1, p2)
}

fn run_day02(day, input) {
  let p1 = day02.solve_day_part1(input)
  let p2 = day02.solve_day_part2(input)

  report(day, p1, p2)
}

fn run_day01(day, input) {
  let p1 = day01.solve_day_part1(input)
  let p2 = day01.solve_day_part2(input)

  report(day, p1, p2)
}

fn report(day, part1, part2) {
  let day_str = int.to_string(day)
  io.println("Day " <> day_str <> " part 1:" <> int.to_string(part1))
  io.println("Day " <> day_str <> " part 2:" <> int.to_string(part2))
}
