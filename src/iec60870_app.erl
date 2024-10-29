%%% +--------------------------------------------------------------+
%%% | Copyright (c) 2024, Faceplate LTD. All Rights Reserved.      |
%%% | Author: Tokenov Alikhan, alikhantokenov@gmail.com            |
%%% +--------------------------------------------------------------+

-module(iec60870_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    iec60870_app_sup:start_link().

stop(_State) ->
    ok.