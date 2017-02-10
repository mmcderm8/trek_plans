
// ESLint esversion: 6
import React from 'react';


 const Activity = props => {
  let url = `/activitieses/${props.id}`;
  let onClick = () => {
    props.onClick(props.id);
  };

  let showDetails;
  if(props.clickedState === props.id) {
    showDetails = <div>
      <p>{props.description}</p>
      <button className="hollow button">
        <a href={url}>Details</a>
      </button>
      <br/>
      <br/>
    </div>;
  }

  return(
    <div>
      <Callout className="callout">
        <div className="small-6 columns">
          <img src={props.image} alt="activity photo" className="activity-img"/>
        </div>
        <div className="small-6 columns">
        <a href={url} className="activity-name">{props.name}</a><br/>
        <i>Created by: {props.creator.username}</i>
          <p onClick = {onClick}>Show More</p>
            {showDetails}
        </div>
      </Callout><br/>
    </div>
  );
};

export default Activity;
