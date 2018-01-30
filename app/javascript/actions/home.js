import api from "../lib/api";

export const HOME_FETCH_REQUEST = "home/FETCH_REQUEST";
export const HOME_FETCH_SUCCESS = "home/FETCH_SUCCESS";
export const HOME_FETCH_FAIL = "home/FETCH_FAIL";

export function fetchHomeRequest() {
  return {
    type: HOME_FETCH_REQUEST
  };
}

export function fetchHomeRequestSuccess(results) {
  return {
    type: HOME_FETCH_SUCCESS,
    results
  };
}

export function fetchHomeRequestFail(error) {
  return {
    type: HOME_FETCH_FAIL,
    error
  };
}

export function fetchHome() {
  return (dispatch, getState) => {
    dispatch(fetchHomeRequest());

    api(getState)
      .get(`/api/home`)
      .then(response => {
        dispatch(fetchHomeRequestSuccess(response.data));
      })
      .catch(error => {
        dispatch(fetchHomeRequestFail(error));
      });
  }
}
