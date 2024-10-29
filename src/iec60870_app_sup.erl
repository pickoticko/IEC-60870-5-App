%%% +--------------------------------------------------------------+
%%% | Copyright (c) 2024, Faceplate LTD. All Rights Reserved.      |
%%% | Author: Tokenov Alikhan, alikhantokenov@gmail.com            |
%%% +--------------------------------------------------------------+

-module(iec60870_app_sup).
-behaviour(supervisor).
-include("iec60870_app.hrl").

-export([
  start_link/0,
  init/1
]).

-export([
  init_application/1
]).

start_link() ->
  supervisor:start_link(?MODULE, []).

init([]) ->
  Config = ?ENV(config, #{}),
  Supervisor = #{
    strategy => one_for_one,
    intensity => ?DEFAULT_MAX_RESTARTS,
    period => ?DEFAULT_MAX_PERIOD
  },
  Application = #{
    id => iec60870_application,
    start => {?MODULE, init_application, [Config]},
    restart => permanent,
    shutdown => ?DEFAULT_STOP_TIMEOUT,
    type => worker,
    modules => [?MODULE, iec60870]
  },
  {ok, {Supervisor, [Application]}}.

init_application(Config) ->
  AppRef = loop(Config),
  ?LOGINFO("Application started: ~p", [AppRef]),
  PID = iec60870:get_pid(AppRef),
  ?LOGINFO("Application PID: ~p", [PID]),
  {ok, PID}.

loop(Config) ->
  try start_application(Config) catch
    _:Error ->
      ?LOGERROR("unable to start an application, error: ~p", [Error]),
      timer:sleep(?DEFAULT_START_RETRY),
      loop(Config)
  end.

start_application(#{client := Config}) ->
  iec60870:start_client(Config);
start_application(#{server := Config}) ->
  iec60870:start_server(Config#{command_handler => get_remote_control_handler()});
start_application(InvalidConfig) ->
  throw({invalid_config, InvalidConfig}).

get_remote_control_handler() ->
  fun(_, Type, IOA, Value) ->
    remote_control_handler(none, Type, IOA, Value)
  end.

remote_control_handler(_, _Type, _IOA, _Value) ->
  {error, empty_handler}.
