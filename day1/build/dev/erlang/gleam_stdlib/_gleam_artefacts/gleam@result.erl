-module(gleam@result).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([is_ok/1, is_error/1, map/2, map_error/2, flatten/1, 'try'/2, then/2, unwrap/2, lazy_unwrap/2, unwrap_error/2, unwrap_both/1, 'or'/2, lazy_or/2, all/1, partition/1, replace/2, replace_error/2, nil_error/1, values/1, try_recover/2]).

-spec is_ok({ok, any()} | {error, any()}) -> boolean().
is_ok(Result) ->
    case Result of
        {error, _} ->
            false;

        {ok, _} ->
            true
    end.

-spec is_error({ok, any()} | {error, any()}) -> boolean().
is_error(Result) ->
    case Result of
        {ok, _} ->
            false;

        {error, _} ->
            true
    end.

-spec map({ok, BVI} | {error, BVJ}, fun((BVI) -> BVM)) -> {ok, BVM} |
    {error, BVJ}.
map(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, Fun(X)};

        {error, E} ->
            {error, E}
    end.

-spec map_error({ok, BVP} | {error, BVQ}, fun((BVQ) -> BVT)) -> {ok, BVP} |
    {error, BVT}.
map_error(Result, Fun) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, Error} ->
            {error, Fun(Error)}
    end.

-spec flatten({ok, {ok, BVW} | {error, BVX}} | {error, BVX}) -> {ok, BVW} |
    {error, BVX}.
flatten(Result) ->
    case Result of
        {ok, X} ->
            X;

        {error, Error} ->
            {error, Error}
    end.

-spec 'try'({ok, BWE} | {error, BWF}, fun((BWE) -> {ok, BWI} | {error, BWF})) -> {ok,
        BWI} |
    {error, BWF}.
'try'(Result, Fun) ->
    case Result of
        {ok, X} ->
            Fun(X);

        {error, E} ->
            {error, E}
    end.

-spec then({ok, BWN} | {error, BWO}, fun((BWN) -> {ok, BWR} | {error, BWO})) -> {ok,
        BWR} |
    {error, BWO}.
then(Result, Fun) ->
    'try'(Result, Fun).

-spec unwrap({ok, BWW} | {error, any()}, BWW) -> BWW.
unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default
    end.

-spec lazy_unwrap({ok, BXA} | {error, any()}, fun(() -> BXA)) -> BXA.
lazy_unwrap(Result, Default) ->
    case Result of
        {ok, V} ->
            V;

        {error, _} ->
            Default()
    end.

-spec unwrap_error({ok, any()} | {error, BXF}, BXF) -> BXF.
unwrap_error(Result, Default) ->
    case Result of
        {ok, _} ->
            Default;

        {error, E} ->
            E
    end.

-spec unwrap_both({ok, BXI} | {error, BXI}) -> BXI.
unwrap_both(Result) ->
    case Result of
        {ok, A} ->
            A;

        {error, A@1} ->
            A@1
    end.

-spec 'or'({ok, BXR} | {error, BXS}, {ok, BXR} | {error, BXS}) -> {ok, BXR} |
    {error, BXS}.
'or'(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second
    end.

-spec lazy_or({ok, BXZ} | {error, BYA}, fun(() -> {ok, BXZ} | {error, BYA})) -> {ok,
        BXZ} |
    {error, BYA}.
lazy_or(First, Second) ->
    case First of
        {ok, _} ->
            First;

        {error, _} ->
            Second()
    end.

-spec all(list({ok, BYH} | {error, BYI})) -> {ok, list(BYH)} | {error, BYI}.
all(Results) ->
    gleam@list:try_map(Results, fun(X) -> X end).

-spec partition_loop(list({ok, BYW} | {error, BYX}), list(BYW), list(BYX)) -> {list(BYW),
    list(BYX)}.
partition_loop(Results, Oks, Errors) ->
    case Results of
        [] ->
            {Oks, Errors};

        [{ok, A} | Rest] ->
            partition_loop(Rest, [A | Oks], Errors);

        [{error, E} | Rest@1] ->
            partition_loop(Rest@1, Oks, [E | Errors])
    end.

-spec partition(list({ok, BYP} | {error, BYQ})) -> {list(BYP), list(BYQ)}.
partition(Results) ->
    partition_loop(Results, [], []).

-spec replace({ok, any()} | {error, BZF}, BZI) -> {ok, BZI} | {error, BZF}.
replace(Result, Value) ->
    case Result of
        {ok, _} ->
            {ok, Value};

        {error, Error} ->
            {error, Error}
    end.

-spec replace_error({ok, BZL} | {error, any()}, BZP) -> {ok, BZL} | {error, BZP}.
replace_error(Result, Error) ->
    case Result of
        {ok, X} ->
            {ok, X};

        {error, _} ->
            {error, Error}
    end.

-spec nil_error({ok, BXL} | {error, any()}) -> {ok, BXL} | {error, nil}.
nil_error(Result) ->
    replace_error(Result, nil).

-spec values(list({ok, BZS} | {error, any()})) -> list(BZS).
values(Results) ->
    gleam@list:filter_map(Results, fun(R) -> R end).

-spec try_recover(
    {ok, BZY} | {error, BZZ},
    fun((BZZ) -> {ok, BZY} | {error, CAC})
) -> {ok, BZY} | {error, CAC}.
try_recover(Result, Fun) ->
    case Result of
        {ok, Value} ->
            {ok, Value};

        {error, Error} ->
            Fun(Error)
    end.
