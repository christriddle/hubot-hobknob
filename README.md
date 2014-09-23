# hobknob-hubot

A hubot script for the Hobknob feature toggle service

## Installation

In hubot project repo, run:

`npm install hobknob-hubot --save`

Then add **hobknob-hubot** to your `external-scripts.json`:

```json
[
  "hobknob-hubot"
]
```

## Sample Interaction

```
user1>> hubot show toggles for application_name
hubot>> Feature toggles for application_name:
hubot>> {
hubot>>   "Toggle1": true,
hubot>>   "Toggle2": false,
hubot>> }
```
