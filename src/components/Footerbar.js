import React, { Component } from 'react'

class Footerbar extends Component {

  render() {
    return (
      <nav className="navbar navbar-dark fixed-bottom bg-dark flex-md-nowrap p-0 shadow">
        <a
          className="navbar-brand col-sm-3 col-md-2 mr-0"
          href="https://github.com/Vishalsutariya/dApp_Repo"
          target="_blank"
          rel="noopener noreferrer"
        >
          by VishalS
        </a>
      </nav>
    );
  }
}

export default Footerbar;
