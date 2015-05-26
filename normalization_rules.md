# Normalization Rules

---

#### Introduction

This document assumes that you are creating LibGuides PNX via oai:dc. The position of your rule in the cascading list may depend on the other rules that exist.

---

#### Display section

###### Type

This rule gives LibGuides the display type of Research Guide. You also need to add the parameter to all corresponding mapping tables.

![Display Type Rule](https://drive.google.com/uc?id=0B6ce4G4CfF1FSVVILXZzc0JrYUE)

###### Title

This rule concats a string to the title of all research guides. After this rule, we run a rule that checks that the string does not exist and do a simple **Copy as Is.**  This creates a title for anything else. We also have these rules in the **Search/Title** section.

![Display Title](https://drive.google.com/uc?id=0B6ce4G4CfF1FN01pRFFfVXQteVU)