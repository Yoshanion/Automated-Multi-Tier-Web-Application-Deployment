import React, { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('http://localhost:5000/') // URL to your backend API
      .then(response => response.json())
      .then(data => setMessage(data.message))
      .catch(error => console.error('There was an error!', error));
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <p>
          Message from API: {message}
        </p>
      </header>
    </div>
  );
}

export default App;