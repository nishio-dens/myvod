import React from "react";
import { Link } from "react-router-dom";

export class AppNavbar extends React.Component {
  render() {
    return (
      <div className="row">
        <nav className="navbar">
          <div className="nav-wrapper">
            <div className="col s12">
              <ul className="left">
                <li> <Link to="/" className="navbar__brand">myVOD</Link> </li>
                <li> <Link to="/watching">Watching</Link> </li>
                <li> <Link to="/new_arrivals">New Arrivals</Link> </li>
                <li> <Link to="/tv_shows">TV Shows</Link> </li>
                <li> <Link to="/channels">Channels</Link> </li>
                <li> <Link to="/admin">Admin</Link> </li>
              </ul>
            </div>
          </div>
        </nav>
      </div>
    );
  }
}
