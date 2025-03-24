import React from 'react';
import './Footer.css';

const Footer = () => {
  return (
    <footer>
      <p>&copy; {new Date().getFullYear()} Fictional Product. All rights reserved.</p>
    </footer>
  );
};

export default Footer;
