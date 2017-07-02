module NotesApp.Model exposing (Model)

import NotesApp.Messages exposing (NotesListFilter(..))

import Notes exposing (Store)

type alias Model =
  { notes: Store
  , showing: NotesListFilter
  }
