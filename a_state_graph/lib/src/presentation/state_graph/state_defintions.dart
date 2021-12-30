// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


// Gist: Bare-bones, the state graph is some state mahcine definition and the app's 
//       interaction with that forms the state graph.

class IState {
  late Branch branch;
  bool reverse = false;
}

typedef StateSet = void Function();

enum Branch { login }
