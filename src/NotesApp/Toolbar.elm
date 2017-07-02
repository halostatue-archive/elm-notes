module NotesApp.Toolbar exposing(view)

import Html exposing (..)
import Html.Attributes exposing (id, class)
import Html.Events exposing (onClick)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..))

import Notes

activeIsFavourite : Model -> String
activeIsFavourite model =
  let
      css = "glyphicon glyphicon-star"
  in
     case model.notes |> Notes.isFavourite of
       False -> css
       True -> css ++ " starred"

view : Model -> Html Msg
view model =
  div [ id "toolbar" ] [
    i [ onClick AddNote, class "glyphicon glyphicon-plus" ] [], 
    i [ onClick CurrentNoteToggleFavourite, class (activeIsFavourite model)] [],
    i [ onClick DeleteCurrentNote, class "glyphicon glyphicon-remove"] []
    ]
