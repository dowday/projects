module Lib
    (
    someFunc
    ,succeed
    ,item
    ,andThen
    ,char
    ,plus
    ,letter
    ,upper
    ,lower
    ,string
    ) where

type  Parser a =  String -> [(a,String)]

succeed :: a -> Parser a
succeed v =  \inp -> [(v,inp)]

zero :: Parser a
zero = \inp -> []

item :: Parser Char
item = \inp -> case inp of
  [] -> []
  (x:xs) -> [(x,xs)]

sat :: (Char -> Bool) -> Parser Char
sat p= item `andThen` \x ->
  if p x then succeed x else zero

char :: Char -> Parser Char
char c = sat (\y -> y==c)

andThen :: Parser a -> (a -> Parser b) -> Parser b
p `andThen` f = \inp -> concat [f v inp' | (v ,inp') <-  p inp ]

plus ::   Parser a -> Parser a -> Parser a
p `plus` q = \inp -> (p inp ++ q inp)

lower :: Parser Char
lower = sat(\x -> 'a' <= x && x <= 'z')

upper :: Parser Char
upper = sat (\x -> 'A' <= x && x <= 'Z')

digit :: Parser Char
digit = sat (\x -> '0'<= x && x <= '9')

letter :: Parser Char
letter =upper `plus` lower

string :: String -> Parser String
string "" = succeed ""
string (x:xs) = char x `andThen` \_ ->
  string xs `andThen` \_->
    succeed (x:xs)

someFunc = putStr "hello"
