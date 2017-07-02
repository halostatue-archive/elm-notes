module Notes.Note
    exposing
        ( Note
        , default
        , empty
        , isFavourite
        , new
        , toggleFavourite
        )

{-| A note to be used in a Notes store.

@docs new, empty, default, toggleFavourite, isFavourite

-}


type alias Note =
    { text : String
    , favourite : Bool
    }


{-| creates a new note with the given text.

    new "" --> Note "" False

    new "hello" --> Note "hello" False

-}
new : String -> Note
new text =
    Note text False


{-| toggles the favourite status of a note.

    empty |> toggleFavourite |> .favourite --> True

    empty |> toggleFavourite |> toggleFavourite |> .favourite --> False

-}
toggleFavourite : Note -> Note
toggleFavourite note =
    { note | favourite = not note.favourite }


{-| indicates whether the note is a favourite or not.

    empty |> isFavourite -> False

    empty |> toggleFavourite |> isFavourite --> True

-}
isFavourite : Note -> Bool
isFavourite note =
    note.favourite


{-| an empty note.

    empty |> .text --> ""

-}
empty : Note
empty =
    new ""


{-| a default note.

    default |> .text --> "New note"

-}
default : Note
default =
    new "New note"
