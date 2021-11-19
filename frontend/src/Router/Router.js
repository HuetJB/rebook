// eslint-disable-next-line
import { BrowserRouter as Router, Route, Switch, Redirect } from "react-router-dom";
// eslint-disable-next-line
import React, {useEffect, useState} from 'react';

import RequestTest from './Axios/RequestTest';
import Home from './Home/Home';
import Header from './Header/Header';
import Footer from './Footer/Footer';

export default function RouterFunction() {

  return (
    <Router>
      <Switch>
        <Header />

        <Route path="/test">
          <RequestTest />
        </Route>
        <Route path="/">
          <Home />
        </Route>
        
        <Footer />
      </Switch>
    </Router>
  );
}

