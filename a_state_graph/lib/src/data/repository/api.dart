// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

typedef HttpSend = Response Function(Request request);

Response send(Request request) {
  // Authentication Set

  // Send request over http

  // Return response - Example
  return const Response("error", 404);
}

class Request {
  final String url;
  final String token;
  const Request(this.url, this.token,);
}

class Response {
  final String data;
  final int code;
  const Response(this.data, this.code,);
}

class ApiState {
  final HttpSend send;
  final String token;
  const ApiState(this.send, this.token,);
}
