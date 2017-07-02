module NotesApp.Subscriptions exposing (subscriptions)

import NotesApp.Model exposing (Model)
import NotesApp.Messages exposing (Msg(..))

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
