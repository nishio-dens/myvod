import { createStore, compose, combineReducers, applyMiddleware } from "redux";
import thunk from "redux-thunk";
import appReducer from "../reducers";

export function configureStore(injectionMiddleware = null) {
  let middleware = null
  if (injectionMiddleware) {
    middleware = compose(applyMiddleware(thunk), applyMiddleware(injectionMiddleware))
  } else {
    middleware = applyMiddleware(thunk)
  }
  /* eslint-disable no-underscore-dangle */
  return createStore(
    appReducer,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
    middleware
  )
  /* eslint-enable */
}
