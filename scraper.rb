#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

# TODO: add members of earlier Knessets
# https://he.wikipedia.org/wiki/קטגוריה:חברי_הכנסת_לפי_כנסות
he_pages = [
  'קטגוריה:חברי_הכנסת_העשרים',
]
he_names = he_pages.map { |p| WikiData::Category.new(p, 'he').member_titles }.flatten.uniq

en_pages = [
  'Category:Members of the 20th Knesset (2015–)',
  'Category:Members of the 19th Knesset (2013–15)',
  'Category:Members of the 18th Knesset (2009–13)',
  'Category:Members of the 17th Knesset (2006–09)',
  'Category:Members of the 16th Knesset (2003–06)',
  'Category:Members of the 15th Knesset (1999–2003)',
  'Category:Members of the 14th Knesset (1996–99)',
  'Category:Members of the 13th Knesset (1992–96)',
  'Category:Members of the 12th Knesset (1988–92)',
  'Category:Members of the 11th Knesset (1984–88)',
  'Category:Members of the 10th Knesset (1981–84)',
  'Category:Members of the 9th Knesset (1977–81)',
  'Category:Members of the 8th Knesset (1974–77)',
  'Category:Members of the 7th Knesset (1969–74)',
  'Category:Members of the 6th Knesset (1965–69)',
  'Category:Members of the 5th Knesset (1961–65)',
  'Category:Members of the 4th Knesset (1959–61)',
  'Category:Members of the 3rd Knesset (1955–59)',
  'Category:Members of the 2nd Knesset (1951–55)',
  'Category:Members of the 1st Knesset (1949–51)',
]
en_names = en_pages.map { |p| WikiData::Category.new(p, 'en').member_titles }.flatten.uniq

sparq = 'SELECT ?item WHERE { ?item wdt:P39 wd:Q4047513 . }'
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { he: he_names, en: en_names }, batch_size: 100)

