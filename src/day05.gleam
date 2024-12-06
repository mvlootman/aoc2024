import gleam/int
import gleam/list
import gleam/order
import gleam/pair
import gleam/result
import gleam/string

pub fn solve_day_part1(input: String) -> Int {
  let #(rules, updates) = parse_input(input)

  updates
  |> list.map(fn(update) { #(check_valid(rules, update), update) })
  |> list.filter(fn(n) { pair.first(n) })
  |> list.map(fn(x) { pair.second(x) })
  |> get_middle_sum()
}

fn get_middle_sum(updates: List(List(String))) -> Int {
  updates
  |> list.map(fn(items) {
    let following = list.drop(items, list.length(items) / 2)
    let assert Ok(middle_item) = list.first(following)
    middle_item |> int.parse |> result.unwrap(0)
  })
  |> int.sum
}

fn check_valid(rules, update) -> Bool {
  list.index_fold(update, True, fn(acc, elem, idx) {
    let following = list.drop(update, idx + 1)
    let item_valid =
      list.all(following, fn(item) {
        !list.contains(rules, item <> "|" <> elem)
      })
    acc && item_valid
  })
}

pub fn solve_day_part2(input: String) -> Int {
  let #(rules, updates) = parse_input(input)

  let result =
    updates
    |> list.map(fn(update) { #(check_valid(rules, update), update) })

  let invalid_items = list.filter(result, fn(x) { !pair.first(x) })
  invalid_items
  |> list.map(fn(x) {
    let #(_, update) = x

    let sort_by_rules = fn(a: String, b: String) -> order.Order {
      let a_after_b = list.contains(rules, b <> "|" <> a)
      case a_after_b {
        True -> order.Gt
        False -> order.Lt
      }
    }

    list.sort(update, by: sort_by_rules)
  })
  |> get_middle_sum
}

fn parse_input(input) {
  let assert [rules, updates] = string.split(input, on: "\n\n")

  let rules = string.split(rules, "\n")
  let updates =
    string.split(updates, "\n") |> list.map(fn(x) { string.split(x, ",") })

  #(rules, updates)
}
