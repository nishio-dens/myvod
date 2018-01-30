import { Map as ImmutableMap, List as ImmutableList } from 'immutable';
import { HOME_FETCH_FAIL, HOME_FETCH_REQUEST, HOME_FETCH_SUCCESS } from "../actions/home";

const initialState = ImmutableMap({
  loading: false,
  newArrivals: ImmutableList([]),
  newPrograms: ImmutableList([])
});

function setNewArrivals(state, results) {
  if (results && results.new_arrivals) {
    const collections = ImmutableList(results.new_arrivals.map(v => ImmutableMap(v)));
    state = state.set("newArrivals", collections);
  }
  return state;
}

function setNewPrograms(state, results) {
  if (results && results.new_programs) {
    const collections = ImmutableList(results.new_programs.map(v => ImmutableMap(v)));
    state = state.set("newPrograms", collections);
  }
  return state;
}

export default function home(state = initialState, action) {
  switch(action.type) {
    case HOME_FETCH_REQUEST:
      state = state.set("loading", true);
      return state;
    case HOME_FETCH_SUCCESS:
      state = state.set("loading", false);
      state = setNewArrivals(state, action.results);
      state = setNewPrograms(state, action.results);
      return state;
    case HOME_FETCH_FAIL:
      state = state.set("loading", false);
      return state;
    default:
      return state;
  }
}