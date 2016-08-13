# Dictionary

Dictionary is like a normal web dictionary, with one difference: the words are
read from a Google Drive spreadsheet. Only words in the spreadsheet will be used,
allowing users to create their custom dictionaries.

It links the words to online dictionaries, thesaurus and collocation dictionaries,
and allows tagging, filtering and sorting.

The connection with Google Drive is done by the [Google Drive Ruby gem](https://github.com/gimite/google-drive-ruby)

# Setup

First of all, it is important to generate the `google_api.json` file inside the
`config` folder. To do that, run the `authorize` rake and follow the instructions:

```
  bin/rake google_drive:authorize
```

# Instructions

To execute, go to the terminal and run:
```
  bin/rake google_drive:import FILE='<file id>'
```

If you want to delete all words and start again, add the option `DELETE_ALL=true`
to the command:

```
  bin/rake google_drive:import FILE='<file id>' DELETE_ALL=true
```
