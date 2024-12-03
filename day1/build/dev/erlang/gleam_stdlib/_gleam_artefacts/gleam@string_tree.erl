-module(gleam@string_tree).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([append_tree/2, prepend_tree/2, from_strings/1, new/0, concat/1, from_string/1, prepend/2, append/2, to_string/1, byte_size/1, join/2, lowercase/1, uppercase/1, reverse/1, split/2, replace/3, is_equal/2, is_empty/1]).
-export_type([string_tree/0, direction/0]).

-type string_tree() :: any().

-type direction() :: all.

-spec append_tree(string_tree(), string_tree()) -> string_tree().
append_tree(Tree, Suffix) ->
    gleam_stdlib:iodata_append(Tree, Suffix).

-spec prepend_tree(string_tree(), string_tree()) -> string_tree().
prepend_tree(Tree, Prefix) ->
    gleam_stdlib:iodata_append(Prefix, Tree).

-spec from_strings(list(binary())) -> string_tree().
from_strings(Strings) ->
    gleam_stdlib:identity(Strings).

-spec new() -> string_tree().
new() ->
    gleam_stdlib:identity([]).

-spec concat(list(string_tree())) -> string_tree().
concat(Trees) ->
    gleam_stdlib:identity(Trees).

-spec from_string(binary()) -> string_tree().
from_string(String) ->
    gleam_stdlib:identity(String).

-spec prepend(string_tree(), binary()) -> string_tree().
prepend(Tree, Prefix) ->
    gleam_stdlib:iodata_append(gleam_stdlib:identity(Prefix), Tree).

-spec append(string_tree(), binary()) -> string_tree().
append(Tree, Second) ->
    gleam_stdlib:iodata_append(Tree, gleam_stdlib:identity(Second)).

-spec to_string(string_tree()) -> binary().
to_string(Tree) ->
    unicode:characters_to_binary(Tree).

-spec byte_size(string_tree()) -> integer().
byte_size(Tree) ->
    erlang:iolist_size(Tree).

-spec join(list(string_tree()), binary()) -> string_tree().
join(Trees, Sep) ->
    _pipe = Trees,
    _pipe@1 = gleam@list:intersperse(_pipe, gleam_stdlib:identity(Sep)),
    gleam_stdlib:identity(_pipe@1).

-spec lowercase(string_tree()) -> string_tree().
lowercase(Tree) ->
    string:lowercase(Tree).

-spec uppercase(string_tree()) -> string_tree().
uppercase(Tree) ->
    string:uppercase(Tree).

-spec do_to_graphemes(binary()) -> list(binary()).
do_to_graphemes(String) ->
    erlang:error(#{gleam_error => panic,
            message => <<"panic expression evaluated"/utf8>>,
            module => <<"gleam/string_tree"/utf8>>,
            function => <<"do_to_graphemes"/utf8>>,
            line => 136}).

-spec reverse(string_tree()) -> string_tree().
reverse(Tree) ->
    string:reverse(Tree).

-spec split(string_tree(), binary()) -> list(string_tree()).
split(Tree, Pattern) ->
    string:split(Tree, Pattern, all).

-spec replace(string_tree(), binary(), binary()) -> string_tree().
replace(Tree, Pattern, Substitute) ->
    gleam_stdlib:string_replace(Tree, Pattern, Substitute).

-spec is_equal(string_tree(), string_tree()) -> boolean().
is_equal(A, B) ->
    string:equal(A, B).

-spec is_empty(string_tree()) -> boolean().
is_empty(Tree) ->
    string:is_empty(Tree).
