#import "template.typ": *

#import "@preview/swank-tex:0.1.0": *

#show: acmart.with(
  format: "acmsmall",
  title: "The Name of the Title is Hope",
  authors: {
  let clarityInstitute = (
      institution: "Institute for Clarity in Documentation",
      streetaddress: "P.O. Box 1212",
      city: "Dublin",
      state: "Ohio",
      country: "USA",
      postcode: "43017-6221")
  let thorvaldGroup = (
        institution: "The Thørväld Group",
        streetaddress: "The Thørväld Circle",
        city: "Hekla",
        country: "Iceland")
  (
    (
      name: "Ben Trovato",
      email: "trovato@corporation.com",
      orcid: "1234-5678-9012",
      affiliation: clarityInstitute),
    (
      name: "G.K.M. Tobin",
      email: "webmaster@marysville-ohio.com",
      affiliation: clarityInstitute),
    (
      name: "Lars Thørväld",
      email: "larst@affiliation.org",
      affiliation: thorvaldGroup),
    (
      name: "Valerie Béranger",
      affiliation: (
        institution: "Inria Paris-Rocquencourt",
        city: "Rocquencourt",
        country: "France")),
    (
      name: "Aparna Patel",
      affiliation: (
        institution: "Rajiv Gandhi University",
        streetaddress: "Rono-Hills",
        city: "Doimukh",
        state: "Arunachal Pradesh",
        country: "India")),
      (
        name: "Huifen Chan",
        affiliation: (
          institution: "Tsinghua University",
          streetaddress: "30 Shuangqing Rd",
          city: "Haidian Qu",
          state: "Beijing Shi",
          country: "China")),
      (
        name: "Charles Palmer",
        email: "cpalmer@prl.com",
        affiliation: (
          institution: "Palmer Research Laboratories",
          streetaddress: "8600 Datapoint Drive",
          city: "San Antonio",
          state: "Texas",
          country: "USA",
          postcode: "78229")),
      (
        name: "John Smith",
        email: "jsmith@affiliation.org",
        affiliation: thorvaldGroup),
      (
        name: "Julius P. Kumquat",
        email: "jpkumquat@consortium.net",
        affiliation: (
          institution: "The Kumquat Consortium",
          // city: "New York", // disabled so that this fits onto one page ...
          country: "USA"))
  )},
  shortauthors: "Trovato et al.",
  abstract: [
    A clear and well-documented Typst document is presented as an
    article formatted for publication by ACM in a conference proceedings
    or journal publication. Based on the "acmart" template, this
    article presents and explains many of the common variations, as well
    as many of the formatting elements an author may use in the
    preparation of the documentation of their work.
  ],
  // ccs: (
  //   ([Computer systems organization], (
  //       (500, [Embedded systems]),
  //       (300, [Redundancy]),
  //       (0,   [Robotics]))),
  //   ([Networks], (
  //       (100, [Network reliability]),))
  // ),
  // keywords: ("datasets", "neural networks", "gaze detection", "text tagging"),
  copyright: "acmlicensed",

  acmJournal: "JACM",
  acmVolume: 37,
  acmNumber: 4,
  acmArticle: 111,
  acmMonth: 8,

  acmYear: 2018,
)

= Introduction
ACM's consolidated article template, introduced in 2017, provides a
consistent Typst style for use across ACM publications, and
incorporates accessibility and metadata-extraction functionality
necessary for future Digital Library endeavors. Numerous ACM and
SIG-specific Typst templates have been examined, and their unique
features incorporated into this single new template.

If you are new to publishing with ACM, this document is a valuable
guide to the process of preparing your work for publication. If you
have published with ACM before, this document provides insight and
instruction into more recent changes to the article template.

The "`acmart`" document class can be used to prepare articles
for any ACM publication --- conference or journal, and for any stage
of publication, from review to final "camera-ready" copy, to the
author's own version, with _very_ few changes to the source.

= Template Overview
As noted in the introduction, the "`acmart`" document class can
be used to prepare many different kinds of documentation --- a
double-blind initial submission of a full-length technical paper, a
two-page SIGGRAPH Emerging Technologies abstract, a "camera-ready"
journal article, a SIGCHI Extended Abstract, and more --- all by
selecting the appropriate _template style_ and _template parameters_.

This document will explain the major features of the document
class. For further information, the _Typst User's Guide_ is
available from https://www.acm.org/publications/proceedings-template.

== Template Styles

The primary parameter given to the "`acmart`" document class is
the _template style_ which corresponds to the kind of publication
or SIG publishing the work. This parameter is enclosed in square
brackets and is a part of the `documentclass` command:
```
  \documentclass[STYLE]{acmart}
```

Journals use one of three template styles. All but three ACM journals
use the `acmsmall` template style:
- `acmsmall`: The default journal template style.
- `acmlarge`: Used by JOCCH and TAP.
- `acmtog`: Used by TOG.

The majority of conference proceedings documentation will use the `acmconf` template style.
- `acmconf`: The default proceedings template style.
- `sigchi`: Used for SIGCHI conference articles.
- `sigplan`: Used for SIGPLAN conference articles.

== Template Parameters

In addition to specifying the _template style_ to be used in
formatting your work, there are a number of _template parameters_
which modify some part of the applied template style. A complete list
of these parameters can be found in the _Typst User's Guide._

Frequently-used parameters, or combinations of parameters, include:
- `anonymous,review`: Suitable for a "double-blind"
  conference submission. Anonymizes the work and includes line
  numbers. Use with the command to print the
  submission's unique ID on each page of the work.
- `authorversion`: Produces a version of the work suitable
  for posting by the author.
- `screen`: Produces colored hyperlinks.

This document uses the following string as the first command in the
source file:
```
\documentclass[acmsmall]{acmart}
```

= Modifications

Modifying the template --- including but not limited to: adjusting
margins, typeface sizes, line spacing, paragraph and list definitions,
and the use of the `\vspace` command to manually adjust the
vertical spacing between elements of your work --- is not allowed.

*Your document will be returned to you for revision if modifications are discovered.*
