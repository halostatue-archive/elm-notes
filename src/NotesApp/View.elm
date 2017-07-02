module NotesApp.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (id)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..))

import NotesApp.Toolbar as Toolbar
import NotesApp.NotesList as NotesList
import NotesApp.Editor as Editor

view : Model -> Html Msg
view model =
  div [ id "app" ] [
    Toolbar.view model,
    NotesList.view model,
    Editor.view model
    ]

