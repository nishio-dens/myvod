import React from "react";

export class PageNotFound extends React.Component {
  render() {
    return (
      <div className="page-not-found valign-wrapper">
        <div className="center-align page-not-found__body">
          <h2 className="page-not-found__text">Page Not Found</h2>

          <p className="page-not-found__text">
            We can't find the page you're looking for.
          </p>
        </div>
      </div>
    );
  }
}