-module(gleam@function).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([compose/2, curry2/1, curry3/1, curry4/1, curry5/1, curry6/1, flip/1, identity/1, constant/1, tap/2, apply1/2, apply2/3, apply3/4]).

-spec compose(fun((DNT) -> DNU), fun((DNU) -> DNV)) -> fun((DNT) -> DNV).
compose(Fun1, Fun2) ->
    fun(A) -> Fun2(Fun1(A)) end.

-spec curry2(fun((DNW, DNX) -> DNY)) -> fun((DNW) -> fun((DNX) -> DNY)).
curry2(Fun) ->
    fun(A) -> fun(B) -> Fun(A, B) end end.

-spec curry3(fun((DOA, DOB, DOC) -> DOD)) -> fun((DOA) -> fun((DOB) -> fun((DOC) -> DOD))).
curry3(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> Fun(A, B, C) end end end.

-spec curry4(fun((DOF, DOG, DOH, DOI) -> DOJ)) -> fun((DOF) -> fun((DOG) -> fun((DOH) -> fun((DOI) -> DOJ)))).
curry4(Fun) ->
    fun(A) -> fun(B) -> fun(C) -> fun(D) -> Fun(A, B, C, D) end end end end.

-spec curry5(fun((DOL, DOM, DON, DOO, DOP) -> DOQ)) -> fun((DOL) -> fun((DOM) -> fun((DON) -> fun((DOO) -> fun((DOP) -> DOQ))))).
curry5(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) -> fun(D) -> fun(E) -> Fun(A, B, C, D, E) end end end
        end
    end.

-spec curry6(fun((DOS, DOT, DOU, DOV, DOW, DOX) -> DOY)) -> fun((DOS) -> fun((DOT) -> fun((DOU) -> fun((DOV) -> fun((DOW) -> fun((DOX) -> DOY)))))).
curry6(Fun) ->
    fun(A) ->
        fun(B) ->
            fun(C) ->
                fun(D) -> fun(E) -> fun(F) -> Fun(A, B, C, D, E, F) end end end
            end
        end
    end.

-spec flip(fun((DPA, DPB) -> DPC)) -> fun((DPB, DPA) -> DPC).
flip(Fun) ->
    fun(B, A) -> Fun(A, B) end.

-spec identity(DPD) -> DPD.
identity(X) ->
    X.

-spec constant(DPE) -> fun((any()) -> DPE).
constant(Value) ->
    fun(_) -> Value end.

-spec tap(DPG, fun((DPG) -> any())) -> DPG.
tap(Arg, Effect) ->
    Effect(Arg),
    Arg.

-spec apply1(fun((DPI) -> DPJ), DPI) -> DPJ.
apply1(Fun, Arg1) ->
    Fun(Arg1).

-spec apply2(fun((DPK, DPL) -> DPM), DPK, DPL) -> DPM.
apply2(Fun, Arg1, Arg2) ->
    Fun(Arg1, Arg2).

-spec apply3(fun((DPN, DPO, DPP) -> DPQ), DPN, DPO, DPP) -> DPQ.
apply3(Fun, Arg1, Arg2, Arg3) ->
    Fun(Arg1, Arg2, Arg3).
