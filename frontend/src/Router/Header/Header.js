import React from 'react';
import {FontAwesomeIcon} from '@fortawesome/react-fontawesome';
import { faFilter } from '@fortawesome/free-solid-svg-icons';
import { faPlusSquare, faStar, faCommentDots, faUser } from '@fortawesome/free-regular-svg-icons';
import '../../Styles/Header.css';

export default function RequestTest() {
    return (
        <div className="header_container">
            <a href="/">
                <img className="header_logo" src="/images/line_logo.png" alt="Logo de ReBook" />    
            </a>
            
            <div className="logos_bouttons">
                <FontAwesomeIcon icon={faPlusSquare} />
                <FontAwesomeIcon icon={faFilter} />
                <FontAwesomeIcon icon={faStar} />
                <FontAwesomeIcon icon={faCommentDots} />
                <FontAwesomeIcon icon={faUser} />
            </div>
        </div>
    );
}

