// eslint-disable-next-line
import { BrowserRouter as Router, Route, Switch, Redirect } from "react-router-dom";
// eslint-disable-next-line
import React, {useEffect, useState} from 'react';
import RequestTest from './Axios/RequestTest';

export default function RouterFunction() {

  return (
    <Router>
      <Switch>
        <Route path="/test">
          <RequestTest />
        </Route>
        <Route path="/">
         <h1>Accueil</h1>
        </Route>
      </Switch>
    </Router>
  );
}

