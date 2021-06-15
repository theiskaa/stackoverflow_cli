# Scli
StackOverflow under your fingers <3 Made with Dart lang.

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

#### Get command usage:

Get questions (Would get excatly 5 question).
```console
scli get
```
Customized get command:
It would get newest questions from [flutter] tag and getted questions length would be 4.
```console
scli get --tag flutter --limit 4
```
 <img width="1000" src="https://raw.githubusercontent.com/theiskaa/stackoverflow_cli/develop/assets/get.png?token=AOCUPZJHI4ZMZRJ7TAWCEU3AZBAOO" alt="Get command result">

#### Search command usage:
It would search question by gave text, and log avaiable questions.
```console
scli search <Search text here>
```
Customized search command:
It would search questions about "Design patterns" by [flutter] tag and would display just 2 question.
```console
scli search "Design patterns" --tag dart --limit 2
```
<img width="1000" src="https://raw.githubusercontent.com/theiskaa/stackoverflow_cli/develop/assets/search.png?token=AOCUPZPW25A7E3VXGF2MRCLAZBAZY" alt="Get command result">

---

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).