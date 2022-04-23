import React from "react";
import heart from "../assets/public/images/CleanAddis.jpg";

const BlockTitle = ({ tagLine, title }) => {
  return (
    <div className="block-title">
      <p>
        <img src={heart} width="15" alt="" />
        {tagLine}
      </p>
      <h3>{title}</h3>
    </div>
  );
};

export default BlockTitle;
