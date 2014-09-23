# hubot-hobknob

A hubot script for the Hobknob feature toggle service

## Installation

In hubot project repo, run:

`npm install hubot-hobknob --save`

Then add **hubot-hobknob** to your `external-scripts.json`:

```json
[
  "hubot-hobknob"
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
