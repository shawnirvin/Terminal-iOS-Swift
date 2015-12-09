# Terminal for iOS - Written in Swift

"Terminal for iOS" is a hobby project of mine. It is a text based program similar to Terminal on Mac OS X or the Command Line tool for windows. However, the syntax I’ve chosen to use within my version of Terminal is different from that of the other programs.

# Design

There is one main view controller called `TerminalViewController` whos view is a `TerminalView`.

The `TerminalView` handles all of the implementation for receiving user input, properly formatting the user input in the text view and handling the logic for the cursor. User input is not directly put into the text view, rather, it is put into an invisible `UITextField` and the input is then translated into the text view.

The `TerminalViewController` basically just exists to ask it's `TerminalView` for user input, keep track of the currently running `Program`, and handles the re-sizing of the text view.

After a user types the input, and enters return, the input is converted from plain text into a `Command` object. The `Command` object stores the raw input along with an array of each word in the input. The `Command` is then passed to the currently running `Program`. The `Program`, which holds a list of available `Functions`, then checks if the `Command` matches any of it's registered `Functions`. If so, it attempts to execute the `Command`.

And repeat.

Programs
========

The currently implemented programs are:

* Main System

The currently planned programs are:

* Calculator
* Read/Write Files

License
=======

This project is licensed under the MIT Open Source license.