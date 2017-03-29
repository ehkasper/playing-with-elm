import Html exposing (..)
import Html.Attributes exposing (class, type_, value)
import Html.Events exposing (..)

type alias Model =
  { items: List String
  , todo: String
  }

type Action
    = UpdateTodo String
    | AddTodo
    | RemoveAll
    | RemoveItem String

-- MODEL
model : Model
model =
  { items = []
  , todo = ""
  }

update: Action -> Model -> Model
update action model =
  case action of
    UpdateTodo text ->
      { model | todo = text }

    AddTodo ->
      { model | items = model.todo :: model.items, todo = "" }

    RemoveAll ->
      {model | items = []}

    RemoveItem item ->
      { model | items = List.filter (\todo -> todo /= item ) model.items}

view : Model -> Html Action
view model =
  div []
  [ div [] [input [ onInput UpdateTodo, value model.todo ] []]
  , div []
    [ button [onClick AddTodo] [text "Add Todo"]
    , button [onClick RemoveAll] [text "RemoveAll"] ]
  , ul [class "my-class"] (List.map (\item -> li [] [text item, button [onClick (RemoveItem item)] [text "x"]]) model.items)
  ]

main =
  Html.beginnerProgram { model = model, view = view, update = update }
