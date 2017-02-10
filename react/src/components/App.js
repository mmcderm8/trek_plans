// ESLint esversion: 6

import React, { Component } from 'react';
import Activity from './Activity';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      activities: [],
      selectedActivityId: null
    };
    this.fetchData = this.fetchData.bind(this);
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount(){
    this.fetchData();
    setInterval(this.fetchData, 3000);
  }

  fetchData(){
    fetch('/api/v1/activities')
    .then(response => {
      if(response.ok) {
        return response.json();
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
        error = new Error(errorMessage);
        throw(error);
      }
    })
    .then(data => {
      this.setState({ activities: data });
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  handleClick(id) {
    if (id === this.state.selectedActivityId) {
      this.setState({ selectedActivityId: null });
    } else {
      this.setState({ selectedActivityId: id });
    }
  }

  render() {
    let activities = this.state.activities.map(activity => {
      return(
        <Activity
        key = {activity.id}
        id = {activity.id}
        creator = {activity.creator}
        name = {activity.name}
        description = {activity.description}
        reviews = {activity.reviews}
        image = {activity.image.url}
        onClick = {this.handleClick}
        clickedState = {this.state.selectedActivityId}
        />
      );
    });

    return(
      <div>
        {activities}
      </div>
    );
  }
}

export default App;
