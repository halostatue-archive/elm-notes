module NotesApp.Editor exposing(view)

import Html exposing (..)
import Html.Attributes exposing (id, class, value)
import Html.Events exposing (onInput)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..))

import Notes

view : Model -> Html Msg
view model =
  div [ id "note-editor" ] [
    textarea [ class "form-control", value <| Notes.activeText <| model.notes,
    onInput (UpdateCurrentNote)
    ] [ ]
    ]
