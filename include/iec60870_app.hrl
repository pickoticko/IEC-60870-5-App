-ifndef(IEC60870_APP).
-define(IEC60870_APP, 1).

-define(LOGERROR(Text), logger:error(Text)).
-define(LOGERROR(Text, Params), logger:error(Text, Params)).
-define(LOGWARNING(Text), logger:warning(Text)).
-define(LOGWARNING(Text, Params), logger:warning(Text, Params)).
-define(LOGINFO(Text), logger:info(Text)).
-define(LOGINFO(Text, Params), logger:info(Text, Params)).
-define(LOGDEBUG(Text), logger:debug(Text)).
-define(LOGDEBUG(Text, Params), logger:debug(Text, Params)).

-define(DEFAULT_MAX_RESTARTS, 10).
-define(DEFAULT_MAX_PERIOD, 1000).
-define(DEFAULT_SCAN_CYCLE, 1000).
-define(DEFAULT_STOP_TIMEOUT, 600000).
-define(DEFAULT_START_RETRY, 5000).

-define(ENV(Key, Default), application:get_env(iec60870_app, Key, Default)).

-endif.