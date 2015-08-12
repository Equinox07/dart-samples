// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Upgrade a regular HTTP request to a WebSocket request using
/// `WebSocketTransformer.upgrade()`.

import 'dart:io';
import 'dart:async';

handleMsg(msg) {
  print('Message received: $msg');
}

main() {
  runZoned(() async {
    var server = await HttpServer.bind('127.0.0.1', 4040);
    server.listen((HttpRequest req) {
      if (req.uri.path == '/ws') {
        // Upgrade a HttpRequest to a WebSocket connection. 
        var socket = await WebSocketTransformer.upgrade(req);
        socket.listen(handleMsg);
      }
    });
  },
  onError: (e) => print("An error occurred."));
}