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
  bin/rake google_drive:import FILE='<file id>' OPTIONS
```

There are some valid options you can use to customize the behavior of the import
procedure:

 * DELETE: deletes all words in the database prior to run the rake. It accepts
    two possible values:
    * 'all': wipe out all entries in the database
    * 'language': delete all entries from an specific language. The language
      to be cleaned will be the one provided on the LANGUAGE option, which is
      English (1) by default
  * LANGUAGE: allows you to chose to which language the words to be imported
    belong. The default value is English, and the codes are as follows:
    * English: 0
    * Portuguese: 1
    * Italian: 2

Example:

```
  bin/rake google_drive:import FILE='1234567878754545' DELETE='all' LANGUAGE='1'
```

It will delete all words from all languages in the database and import the
contents of the spreadsheet '1234567878754545' into the portuguese dictionary.
