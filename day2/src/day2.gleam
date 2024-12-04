import gleam/io
import gleam/string
import gleam/list
import gleam/int
import simplifile

fn part1(input: String) {
  input
  |> split_lines
  |> list.map(str_to_ints)
  |> list.map(inspect_row)
  |> list.count(fn(safe) { safe == True })
}

fn part2(input: String) {
  let ints =
    input
    |> split_lines
    |> list.map(str_to_ints)
  let is_safe_without_dampener =
    ints
    |> list.map(inspect_row)

  let is_safe_with_dampener =
    ints
    |> list.map(fn(int_list) {
      list.range(0, list.length(int_list) - 1)
      |> list.any(fn(i) {
        let #(first, second) = list.split(int_list, i)
        let assert Ok(rest) = list.rest(second)
        list.flatten([first, rest])
        |> inspect_row()
      })
    })
  let is_safe =
    list.map2(is_safe_without_dampener, is_safe_with_dampener, fn(a, b) {
      a || b
    })
  list.count(is_safe, fn(a) { a })
}

fn inspect_row(row: List(Int)) {
  case row {
    [first, ..rest] -> {
      let diffs = get_diffs(rest, first, [])
      let within_range =
        diffs
        |> list.all(fn(diff) {
          let abs_value = int.absolute_value(diff)
          case abs_value {
            _ if abs_value > 0 && abs_value < 4 -> True
            _ -> False
          }
        })
      let count_of_positives =
        diffs
        |> list.count(fn(a) { a > 0 })
      let all_same_sign =
        count_of_positives == list.length(diffs) || count_of_positives == 0
      all_same_sign && within_range
    }
    _ -> False
  }
}

fn get_diffs(remaining_rows: List(Int), previous_int: Int, diffs: List(Int)) {
  case remaining_rows {
    [first, ..rest] -> get_diffs(rest, first, [first - previous_int, ..diffs])
    _ -> diffs
  }
}

fn split_lines(input: String) -> List(String) {
  input
  |> string.split("\n")
}

fn str_to_ints(str: String) -> List(Int) {
  str
  |> string.split(" ")
  |> list.filter_map(int.parse)
}

pub fn main() {
  let file_path = "./src/input.final"
  case simplifile.read(file_path) {
    Ok(str) -> {
      io.debug(part1(str))
      io.debug(part2(str))
      Nil
    }
    _ -> {
      io.println("ERROR!")
    }
  }
}
