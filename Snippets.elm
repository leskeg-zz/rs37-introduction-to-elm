module Snippets exposing (..)

-- Pure functions

add a b = a + b

add 1 2 -- 3

-- Currying functions

add : number -> number -> number
add a b = a + b

add2 = add 2

add2 1 -- 3

-- Piping functions

incrementAge person =
    { person | age = person.age + 1 }

incrementWeight person =
    { person | weight = person.weight + 1 }

incrementAge( incrementWeight( person ) )

person
	|> incrementAge
	|> incrementWeight

-- Immutability

list = [0,1,2]

list ++ 3 -- [0,1,2,3]

list === [0, 1, 2] -- True

[0, 1, 2, 3] === [0, 1, 2, 3] -- True

-- Type checking
[] + [] -- TYPE MISMATCH
[] - [] -- TYPE MISMATCH

[] + {} -- TYPE MISMATCH
{} + [] -- TYPE MISMATCH

[] == [] -- True
[] == not [] -- TYPE MISMATCH

[] ++ [] -- []
{} ++ {} {- TYPE MISMATCH 
Hint: Only strings, text, and lists are appendable. -}

-- Basic Static Types
True : Bool
42 : Int
3.14 : Float
'c' : Char
"String" : String

-- Data Structures
[1, 2, 3] -- List
{ name = "Gabriel", age = 28 } -- Record
("Hello", 123) -- Tuple

-- Type alias
type alias TaskId = Int

type alias Task = { task : String, complete : Bool, taskId: TaskId }
buy : Task
buy =  { task = "Buy", complete = True, taskId = 0 }

buy : Task
buy = Task "Buy" True 0

-- Union Types
type Visibility = All | Active | Completed

type Action 
    = AddTask String
    | RemoveTask TaskId
    | RemoveAllTodos


-- Syntax Problem
foo num =
    if num > 10 then "bigger than 10"

{-
-- SYNTAX PROBLEM ---------------------------
4|   if num > 10 then "bigger than 10"
                                        ^
I am looking for one of the following things:
    an 'else' branch
    an expression
    an infix operator like (+)
    whitespace
-}

-- Maybe
type Maybe a = Just a | Nothing


foo : Int -> Maybe String
foo num =
    if num > 10 then
        Just "bigger than 10"
    else
        Nothing

result0 = foo 11    -- String
result1 = foo 1     -- Nothing


String.toUpper (foo 11) -- TYPE MISMATCH

{-
-- TYPE MISMATCH -----------------------------------
The argument to function `toUpper` is causing a mismatch.
14|          String.toUpper (foo 11)
                            ^^^^^^
Function `toUpper` is expecting the argument to be:
   String

But it is:
   Maybe String
-}

-- Case … of
result : String
result =
  case (foo 11) of
    Just s -> s
    Nothing -> "No result"

String.toUpper result

-- Modules
module MyModule exposing (..)
module MyModule exposing (foo, bar)


import MyModule 
import MyModule as MyM
import MyModule exposing (..)
import MyModule exposing (foo, bar)

-- Command
getRandomGif : String -> Cmd Msg
getRandomGif topic =
   let
       url = "someEndpoint/" ++ topic
   in
       Http.send NewGif (Http.get url decodeGifUrl)