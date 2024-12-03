-module(gleam@pair).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([first/1, second/1, swap/1, map_first/2, map_second/2, new/2]).

-spec first({XI, any()}) -> XI.
first(Pair) ->
    {A, _} = Pair,
    A.

-spec second({any(), XL}) -> XL.
second(Pair) ->
    {_, A} = Pair,
    A.

-spec swap({XM, XN}) -> {XN, XM}.
swap(Pair) ->
    {A, B} = Pair,
    {B, A}.

-spec map_first({XO, XP}, fun((XO) -> XQ)) -> {XQ, XP}.
map_first(Pair, Fun) ->
    {A, B} = Pair,
    {Fun(A), B}.

-spec map_second({XR, XS}, fun((XS) -> XT)) -> {XR, XT}.
map_second(Pair, Fun) ->
    {A, B} = Pair,
    {A, Fun(B)}.

-spec new(XU, XV) -> {XU, XV}.
new(First, Second) ->
    {First, Second}.
