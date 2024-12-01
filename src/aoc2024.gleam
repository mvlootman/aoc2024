import day01
import gleam/io
import simplifile

pub fn main() {
  io.println("Advent of code 2024!")

  let assert Ok(input_day01) = simplifile.read("./inputs/in_day01.txt")
  day01.solve_day_01a(input_day01)
  day01.solve_day_01b(input_day01)
}
