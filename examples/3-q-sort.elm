import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

quicksort: List Int -> List Int
quicksort list =
  case list of
    x::xs -> quicksort (List.filter ((>=)x) xs) ++ [x] ++ quicksort (List.filter ((<)x) xs)
    [] -> []

main =
  text (toString (quicksort [10, 1, 2, 6]))