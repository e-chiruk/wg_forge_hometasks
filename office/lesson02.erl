-module(lesson02).

-export([init/0, get_names/1, filter_females/1]).

init() ->
  [
    { user, "Bob", 29, male},
    { user, "Bill", 21, male},
    { user, "Kate", 24, female},
    { user, "Lora", 23, female}
  ].

get_names(Users) ->
  get_names(Users, []).

get_names([], Acc) -> Acc;
get_names([User|Tail], Acc) ->
  {user, Name,_,_} = User,
  get_names(Tail, [Name|Acc]).

filter_females(Users) ->
  filter_females(Users, []).

filter_females([], Acc) -> lists:reverse(Acc);
filter_females([User|Tail], Acc) ->
  case User of
    {user, _, _, female} -> filter_females(Tail, [User | Acc]);
    {user, _, _, male} -> filter_females(Tail, Acc)
  end.
