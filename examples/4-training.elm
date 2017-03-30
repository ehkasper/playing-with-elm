import Html exposing (..)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (..)

type alias Workout =
  { id: Int
  , time: String
  , wtype: String
  , date: String
  }

type alias Model =
  { items: List Workout
  , time: String
  , wtype: String
  , date: String
  }

type WorkoutAction
  = Time
  | Type
  | Date

type Action
    = UpdateWorkoutTime String
    | UpdateWorkoutWtype String
    | UpdateWorkoutDate String
    | AddWorkout
    --| RemoveAll
    | RemoveItem Int

initialWorkoutState : Workout
initialWorkoutState =
  { id = 0
  , time = ""
  , wtype = ""
  , date = ""
  }

-- MODEL
model : Model
model =
  { items = []
  , time = ""
  , wtype = ""
  , date = ""
  }

update: Action -> Model -> Model
update action model =
  case action of
    UpdateWorkoutTime text ->
      { model | time = text }

    UpdateWorkoutWtype text ->
      { model | wtype = text }

    UpdateWorkoutDate text ->
      { model | date = text }

    AddWorkout ->
      { model | items = model.items ++ [{ id = genId(model.items), time = model.time, wtype = model.wtype, date = model.date }]
              , time = ""
              , wtype = ""
              , date = ""
      }

    --RemoveAll ->
    --  { model | items = [] }

    RemoveItem id ->
      { model | items = List.filter (\workout -> workout.id /= id ) model.items }

-- input [ onInput UpdateTodo, value model.todo ] []
--   , ul [class "my-class"] (List.map (\item -> li [] [text item, button [onClick (RemoveItem item)] [text "x"]]) model.items)

genId: List a -> Int
genId lst =
  (List.length lst) + 1

column: String -> Html a
column content =
  td [] [text content]

columnButton: Int -> Html Action
columnButton id =
  td [] [button [onClick (RemoveItem id)] [text "Excluir"]]

view : Model -> Html Action
view model =
  let
    rows = List.map (\workout -> tr [] [ column workout.time
                                       , column workout.wtype
                                       , column workout.date
                                       , columnButton workout.id ]) model.items
  in
    div []
    [ div [] [ input [ onInput UpdateWorkoutTime, value model.time ] []
             , input [ onInput UpdateWorkoutWtype, value model.wtype ] []
             , input [ onInput UpdateWorkoutDate, value model.date ] []
             , button [onClick AddWorkout] [text "Add"]
             ]
    , div [] [ table [] rows ]
    ]

main =
  Html.beginnerProgram { model = model, view = view, update = update }
