import React from 'react';
import './Hero.css';

const Hero = () => {
  return (
    <section className="hero">
      <div className="hero-content">
        <h1>Welcome to Our Fictional Product</h1>
        <p>Discover the future of innovation.</p>
        <button className="cta-button">Get Started</button>
      </div>
    </section>
  );
};

export default Hero;