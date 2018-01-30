import React from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { fetchHome } from "../../actions/home";
import VideoAsset from "../../components/video_asset";
import VideoProgram from "../../components/video_program";

const mapStateToProps = (state) => {
  return {
    loading: state.home.get("loading"),
    newArrivals: state.home.get("newArrivals"),
    newPrograms: state.home.get("newPrograms"),
  };
};

@connect(mapStateToProps)
export class Home extends React.Component {
  static propTypes = {
    dispatch: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.dispatch(fetchHome());
  }

  renderNewArrivals() {
    return this
      .props
      .newArrivals
      .map(v => <VideoAsset video={v}  key={`asset-video-${v.get("id")}`} />);
  }

  renderNewPrograms() {
    return this
      .props
      .newPrograms
      .map(v => <VideoProgram program={v}  key={`program-video-${v.get("id")}`} />);
  }

  render() {
    return (
      <div className="row page-videos">
        <div className="page-videos__tray">
          <a href="#">
            <h2>New Arrivals</h2>
          </a>
          <div className="page-videos__video-list">
            { this.renderNewArrivals() }
          </div>
        </div>

        <div className="page-videos__tray">
          <h2>New Programs</h2>
          <div className="page-videos__video-list">
            { this.renderNewPrograms() }
          </div>
        </div>
      </div>
    );
  }
}