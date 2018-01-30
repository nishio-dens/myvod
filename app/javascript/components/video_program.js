import React from "react";
import PropTypes from "prop-types";

export default class VideoProgram extends React.Component {
  static propTypes = {
    program: PropTypes.object.isRequired
  };

  render() {
    const { program } = this.props;

    return (
      <div className="col page-videos__video-list-element l2">
        <a href="#">
          <div className="page-videos__video-list-element-image">
            <img className="responsive-img" src={program.get("channel_capture_url")} />
          </div>
        </a>
        <div className="page-videos__video-list-element-title">
          <a href="#">{program.get("name")}</a>
        </div>
        <div className="page-videos__video-list-additional">
          {program.get("channel_name")}
        </div>
      </div>
    );
  }
}
