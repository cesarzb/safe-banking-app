// app/javascript/controllers/password-edit-form_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["password", "strengthMessage"];

  validatePassword() {
    const password = this.passwordTarget.value;
    const strengthLevel = this.calculateStrengthLevel(password);

    this.updateStrengthMessage(strengthLevel);
  }

  updateStrengthMessage(strengthLevel) {
    const strengthMessage = this.strengthMessageTarget;

    if (strengthLevel === "strong") {
      strengthMessage.textContent = "Strong password!";
      strengthMessage.style.color = "green";
    } else if (strengthLevel === "average") {
      strengthMessage.textContent = "Average password.";
      strengthMessage.style.color = "orange";
    } else if (strengthLevel === "toolong") {
      strengthMessage.textContent =
        "Too long password, maximum is 16 characters!";
      strengthMessage.style.color = "red";
    } else {
      strengthMessage.textContent = "Weak password.";
      strengthMessage.style.color = "red";
    }
  }

  calculateStrengthLevel(password) {
    const minLength = 12;
    const maxLength = 16;
    const digitRegex = /\d/;
    const uppercaseRegex = /[A-Z]/;
    const lowercaseRegex = /[a-z]/;
    const specialCharRegex = /[!@#\$%^&*(),.?":{}|<>]/;

    const meetsLengthRequirement =
      password.length >= minLength && password.length <= maxLength;
    const meetsDigitRequirement = digitRegex.test(password);
    const meetsUppercaseRequirement = uppercaseRegex.test(password);
    const meetsLowercaseRequirement = lowercaseRegex.test(password);
    const meetsSpecialCharRequirement = specialCharRegex.test(password);

    if (
      meetsLengthRequirement &&
      meetsDigitRequirement &&
      meetsUppercaseRequirement &&
      meetsLowercaseRequirement &&
      meetsSpecialCharRequirement
    ) {
      return "strong";
    } else if (meetsLengthRequirement) {
      return "average";
    } else if (password.length > maxLength) {
      return "toolong";
    } else {
      return "weak";
    }
  }
}
