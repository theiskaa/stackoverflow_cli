# Scli

 <img width="1000" src="https://github.com/theiskaa/stackoverflow_cli/blob/develop/assets/view-answer.gif" alt="Overview of view and search command">

---
## Installing
The scli are not available yet to install from homebrew or any other package manager.
So then we have to clone repo first of all.
#### Then activate it:
```console
pub global activate --source path <repo path here>
```
After the activating, we have to export the path of pub cache.
add it to your `.bash_profile`/`.bashrc maybe`.
```
export PATH="$PATH":"HOME/.pub-cache/bin"
```

## Available functionalities:
- **Get questions**
  - Options:
   - *Get all (would get 100 question)*
   - *Get by id*
   - *Get by limiting the result*
   - *Get by providing custom tags*
- **Search questions**
   - Options:
   - *Get all (would get 100 question)*
   - *Get by id*
   - *Get by limiting the result*
   - *Get by providing custom tags*


## Usage
To get help about using:
```console
scli help
```

To get help about concrete command:
```console
scli help <command name> 
```

### Get command usage:

Get questions (Would get excatly 5 question).
```console
scli get
```
Customized get command:
It would get newest questions from [flutter] tag and getted questions length would be 4.
```console
scli get --tag flutter --limit 4
```
 <img width="1000" src="https://github.com/theiskaa/stackoverflow_cli/blob/develop/assets/get.png" alt="Get command result">

### Search command usage:
It would search question by gave text, and log avaiable questions.
```console
scli search <Search text here>
```
Customized search command:
It would search questions about "Design patterns" by [flutter] tag and would display just 2 question.
```console
scli search "Design patterns" --tag dart --limit 2
```
<img width="1000" src="https://github.com/theiskaa/stackoverflow_cli/blob/develop/assets/search.png" alt="Search command result">

### View command usage:
It would get answers under question you gave as ID.
```console
scli view --answer <question-id>
```
<img width="1000" src="https://github.com/theiskaa/stackoverflow_cli/blob/develop/assets/view-answers.png" alt="View command result">

---

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
