# elm-notes

Ported from [vuex-notes](https://github.com/halostatue/vuex-notes) to Elm to
help me learn Elm. My understanding is that this is more complex than it should
be in organization, but I followed a large part of the
[NoRedInk/elm-style-guide](https://github.com/NoRedInk/elm-style-guide). The
use of Array to implement the backing store may not be ideal.

## Getting Started

1.  [Install Elm](https://guide.elm-lang.org/install.html).
2.  Clone this repo: `git clone halostatue/elm-notes`.
3.  Install Elm dependencies: `elm-package install --yes`.
4.  Make `notesapp.js`: `elm-make src/NotesApp.elm --output notesapp.js`.
5.  Serve the application: `elm-reactor`.
6.  Visit [http://localhost:8000/index.html](http://localhost:8000/index.html).

## Tests

I have written these as documentation tests.

1.  Install `elm-test` and `elm-verify-examples`: `npm install -g elm-test
    elm-verify-examples`.
2.  Install Elm dependencies: `(cd tests && elm-package install --yes)`.
3.  Generate the test specs and run the tests: `elm-verify-examples &&
    elm-test`.
