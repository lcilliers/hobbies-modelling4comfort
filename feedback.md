---
layout: default
title: Feedback & Contact
permalink: /feedback/
---

# Get in Touch

I'd love to hear from you! Whether you have questions about a project, suggestions for improvements, or just want to share your own modelling experiences, feel free to reach out.

<form action="https://formspree.io/f/mwpggoqz" method="POST" class="feedback-form">
  <div class="form-group">
    <label for="name">Your Name</label>
    <input type="text" name="name" id="name" required>
  </div>
  
  <div class="form-group">
    <label for="email">Your Email</label>
    <input type="email" name="_replyto" id="email" required>
  </div>
  
  <div class="form-group">
    <label for="subject">Subject</label>
    <input type="text" name="_subject" id="subject" placeholder="e.g., Question about Log Cabin project">
  </div>
  
  <div class="form-group">
    <label for="message">Message</label>
    <textarea name="message" id="message" rows="8" required></textarea>
  </div>
  
  <!-- Honeypot for spam protection -->
  <input type="text" name="_gotcha" style="display:none">
  
  <button type="submit" class="submit-button">Send Message</button>
</form>

<style>
.feedback-form {
  max-width: 600px;
  margin: 2rem auto;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-family: inherit;
  font-size: 1rem;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #4CAF50;
  box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.1);
}

.submit-button {
  background-color: #4CAF50;
  color: white;
  padding: 0.75rem 2rem;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s;
}

.submit-button:hover {
  background-color: #45a049;
}

.feedback-cta {
  margin: 2rem 0;
  padding: 1rem;
  background-color: #f9f9f9;
  border-left: 4px solid #4CAF50;
  border-radius: 4px;
}

.feedback-cta p {
  margin: 0;
}
</style>
