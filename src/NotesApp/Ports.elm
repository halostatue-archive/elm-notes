port module NotesApp.Ports exposing (..)

import Notes

-- Store the Notes.Store in localStorage.
port setStorage : Notes.Store -> Cmd msg
