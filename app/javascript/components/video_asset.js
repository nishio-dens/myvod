import React from "react";
import PropTypes from "prop-types";

export default class VideoAsset extends React.Component {
  static propTypes = {
    video: PropTypes.object.isRequired
  };

  render() {
    const { video } = this.props;

    return (
      <div className="col page-videos__video-list-element l2">
        <a href="#">
          <div className="page-videos__video-list-element-image">
            <img className="responsive-img" src={video.get("capture_url")} />
          </div>
        </a>
        <div className="page-videos__video-list-element-title">
          <a href="#">{video.get("name")}</a>
        </div>
        <div className="page-videos__video-list-additional">
          {video.get("program_name")}
        </div>
      </div>
    );
  }
}
