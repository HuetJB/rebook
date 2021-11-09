import React, {useEffect} from 'react';
import axios from 'axios';

export default function RequestTest() {
  useEffect(() => {
    onLoad();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [false]);

  async function onLoad() {
    axios.defaults.baseURL = process.env.REACT_APP_BASE_URL

    axios.post('/auth/local', {
        identifier: 'jbhuet0@gmail.com',
        password: 'testMDP35',
    }).then(value => {
      console.log(value.data);
    });
  }

  return (
    <h1>Hello World</h1>
  );
}

