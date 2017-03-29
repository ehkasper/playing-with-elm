import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

model =
  { shelves = 0 }

update action model =
  if action.actionType == "decrement" then
    { model | shelves = Basics.max 0 (model.shelves - 1) }
  else
    { model | shelves = model.shelves + 1 }


pluralize singular plural quantity =
  if quantity == 1 then
    singular
  else
    plural

view model =
  let
    decreseDisabled = model.shelves <= 0
    increaseDisabled = model.shelves >=  10
    caption =
      ("You're buying "
      ++ (toString model.shelves)
      ++ " "
      ++ (pluralize "shelf" "shelves" 1))
  in
    div
      [id "body"]
      [ h1 [] [text "Pluralizer"]
      , div [] [ button [disabled increaseDisabled, onClick {actionType = "increment"}] [text "increment"] ]
      , div [] [ text caption ]
      , div [] [ button [disabled decreseDisabled, onClick {actionType = "decrement"}] [text "decrement"] ]
      ]

main =
  Html.beginnerProgram { model = model, view = view, update = update }
