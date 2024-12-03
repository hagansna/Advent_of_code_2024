-module(gleam@string_builder).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([new/0, prepend/2, append/2, prepend_builder/2, append_builder/2, from_strings/1, concat/1, from_string/1, to_string/1, byte_size/1, join/2, lowercase/1, uppercase/1, reverse/1, split/2, replace/3, is_equal/2, is_empty/1]).

-spec new() -> gleam@string_tree:string_tree().
new() ->
    gleam_stdlib:identity([]).

-spec prepend(gleam@string_tree:string_tree(), binary()) -> gleam@string_tree:string_tree().
prepend(Builder, Prefix) ->
    gleam_stdlib:iodata_append(gleam_stdlib:identity(Prefix), Builder).

-spec append(gleam@string_tree:string_tree(), binary()) -> gleam@string_tree:string_tree().
append(Builder, Second) ->
    gleam_stdlib:iodata_append(Builder, gleam_stdlib:identity(Second)).

-spec prepend_builder(
    gleam@string_tree:string_tree(),
    gleam@string_tree:string_tree()
) -> gleam@string_tree:string_tree().
prepend_builder(Builder, Prefix) ->
    gleam@string_tree:prepend_tree(Builder, Prefix).

-spec append_builder(
    gleam@string_tree:string_tree(),
    gleam@string_tree:string_tree()
) -> gleam@string_tree:string_tree().
append_builder(Builder, Suffix) ->
    gleam_stdlib:iodata_append(Builder, Suffix).

-spec from_strings(list(binary())) -> gleam@string_tree:string_tree().
from_strings(Strings) ->
    gleam_stdlib:identity(Strings).

-spec concat(list(gleam@string_tree:string_tree())) -> gleam@string_tree:string_tree().
concat(Builders) ->
    gleam_stdlib:identity(Builders).

-spec from_string(binary()) -> gleam@string_tree:string_tree().
from_string(String) ->
    gleam_stdlib:identity(String).

-spec to_string(gleam@string_tree:string_tree()) -> binary().
to_string(Builder) ->
    unicode:characters_to_binary(Builder).

-spec byte_size(gleam@string_tree:string_tree()) -> integer().
byte_size(Builder) ->
    erlang:iolist_size(Builder).

-spec join(list(gleam@string_tree:string_tree()), binary()) -> gleam@string_tree:string_tree().
join(Builders, Sep) ->
    gleam@string_tree:join(Builders, Sep).

-spec lowercase(gleam@string_tree:string_tree()) -> gleam@string_tree:string_tree().
lowercase(Builder) ->
    string:lowercase(Builder).

-spec uppercase(gleam@string_tree:string_tree()) -> gleam@string_tree:string_tree().
uppercase(Builder) ->
    string:uppercase(Builder).

-spec reverse(gleam@string_tree:string_tree()) -> gleam@string_tree:string_tree().
reverse(Builder) ->
    string:reverse(Builder).

-spec split(gleam@string_tree:string_tree(), binary()) -> list(gleam@string_tree:string_tree()).
split(Iodata, Pattern) ->
    gleam@string_tree:split(Iodata, Pattern).

-spec replace(gleam@string_tree:string_tree(), binary(), binary()) -> gleam@string_tree:string_tree().
replace(Builder, Pattern, Substitute) ->
    gleam_stdlib:string_replace(Builder, Pattern, Substitute).

-spec is_equal(gleam@string_tree:string_tree(), gleam@string_tree:string_tree()) -> boolean().
is_equal(A, B) ->
    string:equal(A, B).

-spec is_empty(gleam@string_tree:string_tree()) -> boolean().
is_empty(Builder) ->
    string:is_empty(Builder).
