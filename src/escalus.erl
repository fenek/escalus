%%==============================================================================
%% Copyright 2010 Erlang Solutions Ltd.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%==============================================================================

-module(escalus).

% Public API
-export([suite/0,
         init_per_suite/1,
         end_per_suite/1,
         init_per_testcase/2,
         end_per_testcase/2,
         create_users/1,
         delete_users/1,
         override/3,
         make_everyone_friends/1,
         story/3,
         assert/2,
         assert/3,
         assert_many/2,
         send/2,
         wait_for_stanza/1,
         wait_for_stanza/2,
         wait_for_stanzas/2,
         wait_for_stanzas/3,
         peek_stanzas/1]).

%%--------------------------------------------------------------------
%% Public API
%%--------------------------------------------------------------------

suite() ->
    [{require, escalus_users}].

init_per_suite(Config) ->
    application:start(exml),
    application:start(lxmppc),
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_CaseName, Config) ->
    escalus_cleaner:start(Config).

end_per_testcase(_CaseName, Config) ->
    escalus_cleaner:stop(Config).

%%--------------------------------------------------------------------
%% Public API - forward functions from other modules
%%--------------------------------------------------------------------

-define(FORWARD1(M, F), F(X) -> M:F(X)).
-define(FORWARD2(M, F), F(X, Y) -> M:F(X, Y)).
-define(FORWARD3(M, F), F(X, Y, Z) -> M:F(X, Y, Z)).

?FORWARD1(escalus_users, create_users).
?FORWARD1(escalus_users, delete_users).

?FORWARD1(escalus_story, make_everyone_friends).
?FORWARD3(escalus_story, story).

?FORWARD2(escalus_new_assert, assert).
?FORWARD3(escalus_new_assert, assert).
?FORWARD2(escalus_new_assert, assert_many).

?FORWARD2(escalus_client, send).
?FORWARD1(escalus_client, wait_for_stanza).
?FORWARD2(escalus_client, wait_for_stanza).
?FORWARD2(escalus_client, wait_for_stanzas).
?FORWARD3(escalus_client, wait_for_stanzas).
?FORWARD1(escalus_client, peek_stanzas).

?FORWARD3(escalus_overridables, override).
