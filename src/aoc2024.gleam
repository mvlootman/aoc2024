import day01
import day02
import gleam/io
import simplifile

pub fn main() {
  io.println("Advent of code 2024!")

  run_day02()
  run_day01()
}

fn run_day02() {
  let assert Ok(input_day01) = simplifile.read("./inputs/in_day02.txt")
  day02.solve_day_part1(input_day01)
  day02.solve_day_part2(input_day01)
}

fn run_day01() {
  let assert Ok(input_day01) = simplifile.read("./inputs/in_day01.txt")
  day01.solve_day_part1(input_day01)
  day01.solve_day_part2(input_day01)
}
