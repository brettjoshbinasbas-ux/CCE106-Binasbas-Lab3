# CCE106-Binasbas-Lab3

Flutter StatefulWidget Lab Activity 3: Login & Register Interface

## Student Information
- **Name:** Brett Josh Binasbas
- **Course & Section:** CCE 106 - BSIT

---

## Learning Objectives Completed
1. Created a login and registration interface using `StatefulWidget`.
2. Read user input using `TextEditingController`.
3. Validated input fields using `Form` and `TextFormField`.
4. Dynamically updated interface state using `setState()`.
5. Displayed welcome/home screen upon successful login and allowed logging out.

---

## Customizations Implemented
- **Theme Color:** Updated theme seed color to `Colors.teal`.
- **Application Name:** Added "QuickAuth Portal" header above the form.
- **Student Details:** Added name and section below the form (`Brett Josh Binasbas | CCE 106 - BSIT`).
- **Password Validation:** Enforced an 8-character minimum password length with updated validation error messages.

---

## Laboratory Questions & Answers

### 1. Why does this activity use a StatefulWidget?
This activity requires managing dynamic UI states such as toggling between the Login and Registration forms, tracking authentication status (`_isLoggedIn`), switching password visibility (`_hidePassword`), and holding registered user credentials in memory. A `StatefulWidget` provides a persistent `State` object that stores mutable variables across the widget's lifecycle.

### 2. What happens when setState() is called?
Calling `setState()` notifies the Flutter framework that the widget's internal state has changed. In response, Flutter schedules a rebuild of the widget's subtree by re-executing its `build()` method, allowing the user interface to instantly reflect the updated values.

### 3. What is the purpose of a TextEditingController?
A `TextEditingController` manages the state of editable text input fields by reading user input (`controller.text`), modifying or clearing inputs (`controller.clear()`), and listening for changes. It must also be explicitly released in the `dispose()` method to avoid memory leaks.

### 4. Why does the registered account disappear after restarting the app?
The registered account details are stored solely in volatile memory (RAM) within state variables (`_registeredName`, `_registeredEmail`, `_registeredPassword`) inside `_AuthPageState`. Because no persistent database or file storage was implemented for this practice activity, restarting the application terminates the process and resets all memory variables to null.
