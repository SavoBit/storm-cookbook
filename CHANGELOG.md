# CHANGELOG for storm-project

This file is used to list changes made in each version of storm-project.

## 0.1.0:

* Initial release of storm-project

## 0.3.0

- rberger - Make things a bit more general an parameterized
-- Added comment headers to all recipes and attribute files
-- Made the top level directory an attribute node[:storm][:deploy][:storm_dir]
-- Made the log dir an attribute
-- Defaulted to version 0.9.3
-- Set Version to 0.3.0
-- Parameterized storm.local.dir
-- Parameterized all sotrm variables in templates
-- Stated that Zookeeper is a requirement
-- Made it clear that people have to set the addresses for zookeeper cluster, nimbus and supervisers

## 0.3.2
- prasincs - async logger for storm workers

## 0.3.3
- prasincs - adding async logger for storm cluster
- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
