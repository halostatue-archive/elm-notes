module Notes
    exposing
        ( active
        , activeIndex
        , activeText
        , add
        , delete
        , empty
        , favouriteNotes
        , indexedFavouriteNotes
        , isEmpty
        , isFavourite
        , length
        , notes
        , indexedNotes
        , setActive
        , toggleFavourite
        , update
        , Store
        )

{-| The main Notes store.

@docs empty
@docs isEmpty, length
@docs active, activeIndex, activeText, setActive, toggleFavourite, isFavourite
@docs add, delete
@docs notes, favouriteNotes

    import Array as A
    import Notes.Note as N

-}

import Array exposing (Array)
import Notes.Note as N exposing (Note)


type alias Store =
    { notes : Array Note
    , active : Int
    }


{-| An empty Notes Store.
-}
empty : Store
empty =
    Store Array.empty -1


{-| returns True if there are no notes in the Store.

    empty |> isEmpty --> True

    empty |> add |> isEmpty --> False

-}
isEmpty : Store -> Bool
isEmpty store =
    Array.isEmpty store.notes


{-| returns the number of notes in the Store.

    empty |> length --> 0

    empty |> add |> length --> 1

    empty |> add |> add |> length --> 2

-}
length : Store -> Int
length store =
    Array.length store.notes


{-| returns the active note.

    empty |> active --> Nothing

    empty |> add |> active --> Just N.default

-}
active : Store -> Maybe Note
active store =
    Array.get store.active store.notes


{-| returns the index of the active note.

    empty |> activeIndex --> -1

    empty |> add |> activeIndex --> 0

    empty |> add |> add |> activeIndex --> 1

-}
activeIndex : Store -> Int
activeIndex store =
    store.active


{-| set the active note. Changes nothing if the Store is empty. Performs bounds
checking on the size of the Store.

    three : { notes: A.Array N.Note, active: Int }
    three =
      empty |> add |> add |> add

    setActive empty -2 |> activeIndex --> -1

    setActive three -1 |> activeIndex --> 0

    setActive three 4 |> activeIndex --> 2

    setActive three 1 |> activeIndex --> 1

-}
setActive : Store -> Int -> Store
setActive store index =
    let
        len =
            length store
    in
    if store |> isEmpty then
        store
    else if index >= len then
        { store | active = len - 1 }
    else if index < 0 then
        { store | active = 0 }
    else
        { store | active = index }


{-| adds a new default note to the store and makes it active.

    empty |> add |> activeText --> "New note"

    empty |> add |> activeIndex --> 0

    empty |> add |> add |> activeIndex --> 1

-}
add : Store -> Store
add store =
    let
        length =
            Array.length store.notes

        newStore =
            { store | notes = Array.push N.default store.notes }
    in
    { newStore | active = length }


{-| updates the active note to have the provided text. If store.notes is empty,
add a new note with the provided text. If the active index points to
Nothing, reset active to 0.

    update empty "text" |> activeText --> "text"

    update empty "text" |> activeIndex --> 0

    empty |> add |> activeText --> "New note"

    update (empty |> add) "text" |> activeText --> "text"

-}
update : Store -> String -> Store
update store text =
    if store |> isEmpty then
        let
            newStore =
                { store | notes = Array.push (N.new text) store.notes }
        in
        { newStore | active = 0 }
    else
        case store |> active of
            Nothing ->
                { store | active = 0 }

            Just note ->
                let
                    updatedNote =
                        { note | text = text }
                in
                { store | notes = Array.set store.active updatedNote store.notes }


{-| deletes the active note and changes the active note to the first note.

    empty |> delete --> empty

    empty |> add |> delete --> empty

    setActive (empty |> add |> add |> add) 1 |> delete |> activeIndex
    --> 0

-}
delete : Store -> Store
delete store =
    if store |> isEmpty then
        store
    else
        let
            larr =
                Array.slice 0 store.active store.notes

            rarr =
                Array.slice (store.active + 1) (Array.length store.notes) store.notes

            narr =
                Array.append larr rarr

            active =
                if Array.isEmpty narr then
                    -1
                else
                    0

            newStore =
                { store | active = active }
        in
        { newStore | notes = narr }


{-| toggles the favourite status of the active note.

    empty |> toggleFavourite --> empty

    Maybe.withDefault N.empty (empty |> add |> toggleFavourite |> active)
    |> N.isFavourite --> True

    Maybe.withDefault N.empty (
      empty |> add |> toggleFavourite |> toggleFavourite |> active
    ) |> N.isFavourite --> False

-}
toggleFavourite : Store -> Store
toggleFavourite store =
    if store |> isEmpty then
        store
    else
        case store |> active of
            Nothing ->
                { store | active = 0 }

            Just note ->
                let
                    updatedNote =
                        N.toggleFavourite note
                in
                { store | notes = Array.set store.active updatedNote store.notes }

{-| returns True if the active note is favourited.

    subject : { notes: A.Array N.Note, active: Int }
    subject = 
        empty |> add |> add |> toggleFavourite

    empty |> isFavourite --> False

    empty |> add |> isFavourite --> False

    subject |> isFavourite --> True

    setActive subject 0  |> isFavourite --> False
-}
isFavourite : Store -> Bool
isFavourite store =
    case store |> active of
        Nothing ->
            False
        Just note ->
            note |> N.isFavourite

{-| returns the active note's text, or an empty string if not present.

    empty |> activeText --> ""

    empty |> add |> activeText --> "New note"

-}
activeText : Store -> String
activeText store =
    if store |> isEmpty then
        ""
    else
        case store |> active of
            Nothing ->
                ""

            Just note ->
                note.text


{-| returns all notes as a List.

    empty |> notes --> []

    empty |> add |> notes --> List.singleton N.default

-}
notes : Store -> List Note
notes store =
    Array.toList store.notes

{-| returns all notes as a List with index.

    empty |> indexedNotes --> []

    empty |> add |> indexedNotes --> List.singleton (0, N.default)

    empty |> add |> add |> indexedNotes
    --> [(0, N.default), (1, N.default)]

-}
indexedNotes : Store -> List (Int, Note)
indexedNotes store =
    Array.toIndexedList store.notes

{-| returns the favourite notes as a List.

    empty |> favouriteNotes --> []

    empty |> add |> favouriteNotes --> []

    empty |> add |> toggleFavourite |> favouriteNotes
    --> List.singleton (N.toggleFavourite N.default)

    empty |> add |> add |> toggleFavourite |> favouriteNotes
    --> List.singleton (N.toggleFavourite N.default)

    empty |> add |> toggleFavourite |> add |> toggleFavourite |> favouriteNotes
    --> List.repeat 2 (N.toggleFavourite N.default)

-}
favouriteNotes : Store -> List Note
favouriteNotes store =
    Array.filter N.isFavourite store.notes |> Array.toList

{-| returns the favourite notes as a List with index; the index is generated
before filtering.

    empty |> indexedFavouriteNotes --> []

    empty |> add |> indexedFavouriteNotes --> []

    empty |> add |> toggleFavourite |> indexedFavouriteNotes
    --> List.singleton (0, (N.toggleFavourite N.default))

    empty |> add |> add |> toggleFavourite |> indexedFavouriteNotes
    --> List.singleton (1, (N.toggleFavourite N.default))

    empty |> add |> toggleFavourite |> add |> toggleFavourite |> indexedFavouriteNotes
    --> [(0, (N.toggleFavourite N.default)), (1, (N.toggleFavourite N.default))]

-}
indexedFavouriteNotes : Store -> List (Int, Note)
indexedFavouriteNotes store =
    let
        filter =
            \(_, note) -> N.isFavourite note
    in

    List.filter filter (Array.toIndexedList store.notes)
