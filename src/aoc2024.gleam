import day01
import day02
import day03
import gleam/int
import gleam/io
import simplifile

pub fn main() {
  io.println("Advent of code 2024!")

  run_day03()
  run_day02()
  run_day01()
}

fn run_day03() {
  let assert Ok(input) = simplifile.read("./inputs/in_day03.txt")
  let p1 = day03.solve_day_part1(input)
  let p2 = day03.solve_day_part2(input)

  io.println("Day 3 part 1:" <> int.to_string(p1))
  io.println("Day 3 part 2:" <> int.to_string(p2))
}

fn run_day02() {
  let assert Ok(input) = simplifile.read("./inputs/in_day02.txt")
  let p1 = day02.solve_day_part1(input)
  let p2 = day02.solve_day_part2(input)

  report(2, p1, p2)
}

fn run_day01() {
  let assert Ok(input) = simplifile.read("./inputs/in_day01.txt")
  let p1 = day01.solve_day_part1(input)
  let p2 = day01.solve_day_part2(input)
  
  report(1, p1, p2)
}

fn report(day, part1, part2) {
  let day_str = int.to_string(day)
  io.println("Day " <> day_str <> " part 1:" <> int.to_string(part1))
  io.println("Day " <> day_str <> " part 2:" <> int.to_string(part2))
}
