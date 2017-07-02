module NotesApp.Messages exposing (Msg(..), NotesListFilter(..))

type NotesListFilter = ShowAllNotes
                     | ShowFavouriteNotes

type Msg
  = NoOp
  | AddNote
  | CurrentNoteToggleFavourite
  | DeleteCurrentNote
  | FilterNoteList NotesListFilter
  | SetActiveNote Int
  | UpdateCurrentNote String
