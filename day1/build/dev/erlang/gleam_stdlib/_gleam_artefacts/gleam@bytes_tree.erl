-module(gleam@bytes_tree).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([append_tree/2, prepend_tree/2, concat/1, new/0, from_string/1, prepend_string/2, append_string/2, from_string_tree/1, from_bit_array/1, prepend/2, append/2, concat_bit_arrays/1, to_bit_array/1, byte_size/1]).
-export_type([bytes_tree/0]).

-opaque bytes_tree() :: {bytes, bitstring()} |
    {text, gleam@string_tree:string_tree()} |
    {many, list(bytes_tree())}.

-spec append_tree(bytes_tree(), bytes_tree()) -> bytes_tree().
append_tree(First, Second) ->
    gleam_stdlib:iodata_append(First, Second).

-spec prepend_tree(bytes_tree(), bytes_tree()) -> bytes_tree().
prepend_tree(Second, First) ->
    gleam_stdlib:iodata_append(First, Second).

-spec concat(list(bytes_tree())) -> bytes_tree().
concat(Trees) ->
    gleam_stdlib:identity(Trees).

-spec new() -> bytes_tree().
new() ->
    gleam_stdlib:identity([]).

-spec from_string(binary()) -> bytes_tree().
from_string(String) ->
    gleam_stdlib:wrap_list(String).

-spec prepend_string(bytes_tree(), binary()) -> bytes_tree().
prepend_string(Second, First) ->
    gleam_stdlib:iodata_append(gleam_stdlib:wrap_list(First), Second).

-spec append_string(bytes_tree(), binary()) -> bytes_tree().
append_string(First, Second) ->
    gleam_stdlib:iodata_append(First, gleam_stdlib:wrap_list(Second)).

-spec from_string_tree(gleam@string_tree:string_tree()) -> bytes_tree().
from_string_tree(Tree) ->
    gleam_stdlib:wrap_list(Tree).

-spec from_bit_array(bitstring()) -> bytes_tree().
from_bit_array(Bits) ->
    _pipe = Bits,
    _pipe@1 = gleam_stdlib:bit_array_pad_to_bytes(_pipe),
    gleam_stdlib:wrap_list(_pipe@1).

-spec prepend(bytes_tree(), bitstring()) -> bytes_tree().
prepend(Second, First) ->
    gleam_stdlib:iodata_append(from_bit_array(First), Second).

-spec append(bytes_tree(), bitstring()) -> bytes_tree().
append(First, Second) ->
    gleam_stdlib:iodata_append(First, from_bit_array(Second)).

-spec concat_bit_arrays(list(bitstring())) -> bytes_tree().
concat_bit_arrays(Bits) ->
    _pipe = Bits,
    _pipe@1 = gleam@list:map(_pipe, fun(B) -> from_bit_array(B) end),
    gleam_stdlib:identity(_pipe@1).

-spec to_list(list(list(bytes_tree())), list(bitstring())) -> list(bitstring()).
to_list(Stack, Acc) ->
    case Stack of
        [] ->
            Acc;

        [[] | Remaining_stack] ->
            to_list(Remaining_stack, Acc);

        [[{bytes, Bits} | Rest] | Remaining_stack@1] ->
            to_list([Rest | Remaining_stack@1], [Bits | Acc]);

        [[{text, Tree} | Rest@1] | Remaining_stack@2] ->
            Bits@1 = gleam_stdlib:identity(unicode:characters_to_binary(Tree)),
            to_list([Rest@1 | Remaining_stack@2], [Bits@1 | Acc]);

        [[{many, Trees} | Rest@2] | Remaining_stack@3] ->
            to_list([Trees, Rest@2 | Remaining_stack@3], Acc)
    end.

-spec to_bit_array(bytes_tree()) -> bitstring().
to_bit_array(Tree) ->
    erlang:list_to_bitstring(Tree).

-spec byte_size(bytes_tree()) -> integer().
byte_size(Tree) ->
    erlang:iolist_size(Tree).
