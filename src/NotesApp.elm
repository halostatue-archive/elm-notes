module NotesApp exposing (main)

import Html exposing (Html)
import Rocket exposing (..)

import NotesApp.Messages exposing (Msg(..), NotesListFilter(..))
import NotesApp.Subscriptions exposing (subscriptions)
import NotesApp.Model exposing (Model)
import NotesApp.Update exposing (update)
import NotesApp.View exposing (view)
import NotesApp.Ports

import Notes

initialModel : Model
initialModel =
  { notes = Notes.empty
  , showing = ShowAllNotes
  }

init : Maybe Notes.Store -> (Model, List (Cmd Msg))
init savedNotesStore =
  case savedNotesStore of
    Nothing -> initialModel => []
    Just notes -> { initialModel | notes = notes } => []

-- UPDATE

updateWithStorage : Msg -> Model -> (Model, List (Cmd Msg))
updateWithStorage msg model =
  let
      (newModel, cmds) =
        update msg model
  in
     newModel => [ NotesApp.Ports.setStorage newModel.notes ] ++ cmds


-- MAIN
main : Program (Maybe Notes.Store) Model Msg
main =
  Html.programWithFlags
    { init = init >> batchInit
    , view = view
    , update = updateWithStorage >> batchUpdate
    , subscriptions = \_ -> Sub.none
    }
