module NotesApp.Update exposing (update)

import Rocket exposing (..)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..))

import Notes

update : Msg -> Model -> (Model, List (Cmd Msg))
update msg model =
  case msg of
    NoOp ->
      model => []
    AddNote ->
      let
          newNotes = model.notes |> Notes.add
      in
          { model | notes = newNotes } => []
    CurrentNoteToggleFavourite ->
      let
          newNotes = model.notes |> Notes.toggleFavourite
      in
          { model | notes = newNotes } => []
    DeleteCurrentNote ->
      let
          newNotes = model.notes |> Notes.delete
      in
          { model | notes = newNotes } => []
    FilterNoteList nowShowing ->
      { model | showing = nowShowing } => []
    SetActiveNote index ->
      let
          newNotes = Notes.setActive model.notes index
      in
          { model | notes = newNotes } => []
    UpdateCurrentNote text ->
      let
          newNotes = Notes.update model.notes text
      in
          { model | notes = newNotes } => []
