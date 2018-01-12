import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";
import { Switch, Route } from "react-router-dom";
import createHistory from "history/createHashHistory";
import { ConnectedRouter, routerMiddleware } from "react-router-redux";

import { configureStore } from "../stores/app_store";
import { PageNotFound } from "../components/page_not_found";
import { AppNavbar } from "../components/app_navbar";
import { Home } from "../features/home/index";

const history = createHistory();
const middleware = routerMiddleware(history);
const appStore = configureStore(middleware);

class App extends React.Component {
  render() {
    const { store, history } = this.props;

    return (
      <Provider store={store}>
        <ConnectedRouter history={history}>
          <div>
            <div className="container-full">
              <AppNavbar />

              <Switch>
                <Route exact path="/" component={Home} />
                <Route path="*" component={PageNotFound} />
              </Switch>
            </div>
          </div>
        </ConnectedRouter>
      </Provider>
    );
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("app");
  if (node) {
    ReactDOM.render(<App store={appStore} history={history} />, node);
  }
});
