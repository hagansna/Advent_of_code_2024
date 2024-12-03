import gleam/io
import gleam/string
import gleam/list
import gleam/int
import simplifile

pub fn main() {
  let file_path = "./src/input.final"
  let assert Ok(input) = simplifile.read(file_path)
  let vals = string.split(input, on: "\n")
  let first_list =
    list.map(vals, fn(line) {
      let parts = string.split(line, " ")
      let numbers = list.filter_map(parts, int.parse)
      case numbers {
        [a, _] -> a
        _ -> 0
      }
    })

  let second_list =
    list.map(vals, fn(line) {
      let parts = string.split(line, " ")
      let numbers = list.filter_map(parts, int.parse)
      case numbers {
        [_, b] -> b
        _ -> 0
      }
    })

  let first_list_sorted = list.sort(first_list, by: int.compare)
  let second_list_sorted = list.sort(second_list, by: int.compare)

  // PART ONE, SUM ABSOLUTE DIFFERENCE OF SORTED LISTS
  let final_list =
    list.map2(first_list_sorted, second_list_sorted, fn(first, second) {
      int.absolute_value(first - second)
    })

  let part_one_final = list.fold(final_list, 0, fn(a, b) { a + b })

  //PART TWO: FREQUENCY OF LIST ONE ITEMS IN LIST TWO
  let frequency =
    list.map(first_list_sorted, fn(num) {
      let num_count = list.count(second_list_sorted, fn(a) { a == num })
      num_count * num
    })

  let part_two_final =
    frequency
    |> list.fold(from: 0, with: fn(in, a) { a + in })

  io.debug(part_one_final)
  io.debug(part_two_final)
}
