import { useState } from "react";
import "./Navbar.css";

const Navbar = () => {
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <nav className="navbar">
      <div className="logo">MyLogo</div>

      {/* Hamburger Menu */}
      <div 
        className="menu-icon" 
        onClick={() => setMenuOpen(!menuOpen)} 
        aria-label="Toggle menu"
      >
        ☰
      </div>

      <ul className={`nav-links ${menuOpen ? "active" : ""}`}>
        <li><a href="/#home" onClick={() => setMenuOpen(false)}>Home</a></li>
        <li><a href="/#about" onClick={() => setMenuOpen(false)}>About</a></li>
        <li><a href="/#services" onClick={() => setMenuOpen(false)}>Services</a></li>
        <li><a href="/#contact" onClick={() => setMenuOpen(false)}>Contact</a></li>
      </ul>
    </nav>
  );
};

export default Navbar;
