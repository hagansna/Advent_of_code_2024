-module(day1).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([main/0]).

-spec main() -> integer().
main() ->
    File_path = <<"./src/input.final"/utf8>>,
    _assert_subject = simplifile:read(File_path),
    {ok, Input} = case _assert_subject of
        {ok, _} -> _assert_subject;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Assertion pattern match failed"/utf8>>,
                        value => _assert_fail,
                        module => <<"day1"/utf8>>,
                        function => <<"main"/utf8>>,
                        line => 9})
    end,
    Vals = gleam@string:split(Input, <<"\n"/utf8>>),
    First_list = gleam@list:map(
        Vals,
        fun(Line) ->
            Parts = gleam@string:split(Line, <<" "/utf8>>),
            Numbers = gleam@list:filter_map(Parts, fun gleam_stdlib:parse_int/1),
            case Numbers of
                [A, _] ->
                    A;

                _ ->
                    0
            end
        end
    ),
    Second_list = gleam@list:map(
        Vals,
        fun(Line@1) ->
            Parts@1 = gleam@string:split(Line@1, <<" "/utf8>>),
            Numbers@1 = gleam@list:filter_map(
                Parts@1,
                fun gleam_stdlib:parse_int/1
            ),
            case Numbers@1 of
                [_, B] ->
                    B;

                _ ->
                    0
            end
        end
    ),
    First_list_sorted = gleam@list:sort(First_list, fun gleam@int:compare/2),
    Second_list_sorted = gleam@list:sort(Second_list, fun gleam@int:compare/2),
    Final_list = gleam@list:map2(
        First_list_sorted,
        Second_list_sorted,
        fun(First, Second) -> gleam@int:absolute_value(First - Second) end
    ),
    Part_one_final = gleam@list:fold(
        Final_list,
        0,
        fun(A@1, B@1) -> A@1 + B@1 end
    ),
    Frequency = gleam@list:map(
        First_list_sorted,
        fun(Num) ->
            Num_count = gleam@list:count(
                Second_list_sorted,
                fun(A@2) -> A@2 =:= Num end
            ),
            Num_count * Num
        end
    ),
    Part_two_final = begin
        _pipe = Frequency,
        gleam@list:fold(_pipe, 0, fun(In, A@3) -> A@3 + In end)
    end,
    gleam@io:debug(Part_one_final),
    gleam@io:debug(Part_two_final).
