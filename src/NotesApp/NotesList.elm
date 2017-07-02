module NotesApp.NotesList exposing(view)

import Html exposing (..)
import Html.Attributes exposing (id, class, type_, href)
import Html.Attributes.Extra exposing (role)
import Html.Events exposing (onClick)
import Html.Lazy exposing (lazy)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..), NotesListFilter(..))

import Notes.Note exposing (Note)
import Notes

showClass : Model -> NotesListFilter -> String
showClass model showing =
  let
      css = "btn btn-default"
  in
     if model.showing == showing then
        css ++ " active"
    else
        css

filterButton : NotesListFilter -> NotesListFilter -> String -> Html Msg
filterButton filter filterType label =
  let
      default = "btn btn-default"
      css = if filter == filterType then
               default ++ " active"
            else
               default
  in
      button [ type_ "button", class css, onClick (FilterNoteList filterType) ] [ text label ]


filterButtons : NotesListFilter -> Html Msg
filterButtons filter =
  div [class "btn-group btn-group-justified", role "group"] [
    div [class "btn-group", role "group"] [
      filterButton filter ShowAllNotes "All Notes"
    ],
    div [class "btn-group", role "group"] [
      filterButton filter ShowFavouriteNotes "Favourites"
    ]
  ]

viewNote : Int -> (Int, Note) -> Html Msg
viewNote activeIndex (index, note) =
  let
      defaultCss = "list-group-item"
      css = if activeIndex == index then
               defaultCss ++ " active"
            else
               defaultCss
  in
     a [ class css, href "#", onClick (SetActiveNote index) ] [
       text (String.left 30 (String.trim note.text))
       ]

filterNotes : NotesListFilter -> Notes.Store -> List (Int, Note)
filterNotes filter notes =
  case filter of
    ShowAllNotes ->
      notes |> Notes.indexedNotes
    ShowFavouriteNotes ->
      notes |> Notes.indexedFavouriteNotes

viewNotes : Model -> List (Html Msg)
viewNotes model =
  List.map (viewNote model.notes.active) (filterNotes model.showing model.notes)

view : Model -> Html Msg
view model =
  div [id "notes-list"] [
    div [id "list-header"] [
      h2 [] [ text "elm-Notes" ],
      filterButtons model.showing
      ],
    div [ class "container" ] [
      div [ class "list-group" ] (viewNotes model)
      ]
    ]
