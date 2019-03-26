-module(task_4).

-export([dropwhile/2, takewhile/2]).

-include_lib("eunit/include/eunit.hrl").


%% implement lists:dropwhile/2
%% http://www.erlang.org/doc/man/lists.html#dropwhile-2
dropwhile(_Pred, []) -> [];
dropwhile(Pred, List) ->
    [Head | Tail] = List,
    case Pred(Head) of
        true -> dropwhile(Pred, Tail);
        false -> List
    end.


dropwhile_test() ->
    F = fun(Val) -> Val =:= 32 end,
    ?assertEqual("hello", dropwhile(F, "   hello")),
    ?assertEqual([], dropwhile(F, [])),
    ?assertEqual([1,2,3], dropwhile(F, [1,2,3])),
    ?assertEqual([3,4], dropwhile(F, [32,3,4])),
    ?assertEqual([3,4], dropwhile(F, [32,32,3,4])),
    ?assertEqual([3,32,4,32], dropwhile(F, [32,32,32,32,32,32,3,32,4,32])),
    ok.


%% implement lists:takewhile/2
%% http://www.erlang.org/doc/man/lists.html#takewhile-2
takewhile(Pred, List) ->
    takewhile(Pred, List, []).

takewhile(_Pred, [], Acc) -> lists:reverse(Acc);
takewhile(Pred, [Head | Tail], Acc) ->
    case Pred(Head) of
        true -> takewhile(Pred, Tail, [Head | Acc]);
        false -> takewhile(Pred, [], Acc)
    end.


takewhile_test() ->
    F = fun(Val) -> Val =:= 32 end,
    ?assertEqual("   ", takewhile(F, "   hello")),
    ?assertEqual([], takewhile(F, [])),
    ?assertEqual([], takewhile(F, [1,2,3])),
    ?assertEqual([32], takewhile(F, [32,3,4])),
    ?assertEqual([32,32], takewhile(F, [32,32,3,4])),
    ?assertEqual([32,32,32,32,32,32], takewhile(F, [32,32,32,32,32,32,3,32,4,32])),
    F2 = fun(Val) -> Val < 5 end,
    ?assertEqual([1,2,3,4], takewhile(F2, [1,2,3,4,5,6,7,8])),
    ok.