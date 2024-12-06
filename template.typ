#let mainFont = "Linux Libertine O"
#let sfFont = "Linux Biolinum O"

#let bigskipamount = 12pt
#let medskipamount = bigskipamount / 2
#let smallskipamount = medskipamount / 2

#let sf(body) = text(font: sfFont, body)

#let acmart(
  // Currently supported formats are:
  //  - acmsmall
  format: "acmsmall",
  
  // Title, subtitle, authors, abstract, ACM ccs, keywords
  title: "Title",
  subtitle: none,
  shorttitle: none,
  authors: (),
  shortauthors: none,
  abstract: none,
  ccs: none,
  keywords: none,

  // acm journal
  acmJournal: none,
  acmVolume: 1,
  acmNumber: 1,
  acmArticle: none,
  acmMonth: 5,

  // acm information
  acmYear: 2023,
  acmDOI: "XXXXXXX.XXXXXXX",

  // copyright
  copyright: none,
  copyrightYear: 2023,

  // paper's content
  body
) = {
  let journal = if acmJournal == "JACM" {
    (
      name: "Journal of the ACM",
      nameShort: "J. ACM"
    )
  } else {
    none
  }

  let displayMonth(month) = (
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ).at(month - 1)

  if shorttitle == none {
    shorttitle = title
  }

  if shortauthors == none {
    shortauthors = authors.map(author => author.name).join(", ", last: " and ")
  }

  // Set document metadata
  set document(title: title, author: authors.map(author => author.name))

  set text(fill: blue)

  // Configure the page.
  set page(
    width:  6.75in,
    height: 10in,
    margin: (
      top:    58pt + 27pt,
      bottom: 39pt + 24pt,
      left:   46pt,
      right:  46pt
    ),
    header: context {
      set text(size: 8pt, font: sfFont)
      let (currentpage,) = counter(page).get()
      if currentpage == 1 {
        
      } else  {
        let acmArticlePage = [#acmArticle:#counter(page).display()]
        [
          #block(
            height: 10pt,
            width: 100%, 
            if calc.rem(currentpage, 2) == 0 [
              #acmArticlePage
              #h(1fr)
              #shortauthors
            ] else [
              #shorttitle
              #h(1fr)
              #acmArticlePage
            ]
          )
          #v(17pt)
        ]
      }
    },
    header-ascent: 0%,
    footer: context {
      set text(size: 8pt)
      let (currentpage,) = counter(page).get()
      let currentfooting = [
          #journal.nameShort,
          Vol. #acmVolume,
          No. #acmNumber,
          Article #acmArticle.
          Publication date: #displayMonth(acmMonth) #acmYear.
        ]
      block(
        height: 24pt,
        width: 100%,
        if calc.rem(currentpage, 2) == 0 {
          align(bottom + left, currentfooting)
          } else {
          align(bottom + right, currentfooting)
          }
      )
    },
    footer-descent: 0%,
  )

  set text(font: mainFont, size: 10pt)
  
  // set titlepage
  {
    set par(justify: true, leading: 0.555em, spacing: 0pt)

    // Display title
    {
      set text(font: sfFont, size: 14.4pt, weight: "bold")
      par(title)
      v(16.5pt)
    }

    // Display authors
    {
      set par(leading: 5.7pt)
      let displayAuthor(author) = [#text(font: sfFont, size: 11pt, upper(author.name))]
      let displayAuthors(authors) = authors.map(displayAuthor).join(", ", last: " and ")

      let displayAffiliation(affiliation) = [,#text(font: mainFont, size: 9pt)[
        #affiliation.institution, #affiliation.country]\
      ]
      par({
        let affiliation = none
        let currentAuthors = ()
        for author in authors {
          // if affiliation changes, print author list and affiliation
          if author.affiliation != affiliation and affiliation != none {
            displayAuthors(currentAuthors)
            displayAffiliation(affiliation)
            currentAuthors = ()
          }
          currentAuthors.push(author)
          affiliation = author.affiliation
        }
        displayAuthors(currentAuthors)
        displayAffiliation(affiliation)
      })
      v(12pt)
    }

    // Display abstract
    par(text(size: 9pt, abstract))
    v(9.5pt)

    // Display CSS concepts:
    par(text(size: 9pt)[CCS Concepts: #{
      ccs.fold((), (acc, concept) => {
        acc + ([
          #box(baseline: -50%, circle(radius: 1.25pt, fill: black))
          #strong(concept.at(0))
          #sym.arrow.r
          #{concept.at(1).fold((), (acc, subconcept) => {
              acc + (if subconcept.at(0) >= 500 {
                [ *#subconcept.at(1)*]
              } else if subconcept.at(0) >= 300 {
                [ _#subconcept.at(1)_]
              } else {
                [ #subconcept.at(1)]
              }, )
            }).join(";")
          }],)
      }).join(";")
      "."
    }])
    v(9.5pt)

    // Display keywords
    par(text(size: 9pt)[
      Additional Key Words and Phrases: #keywords.join(", ")])
    v(9.5pt)

    // Display ACM reference format
    par(text(size: 9pt, context [
      #strong[ACM Reference Format:]\
      #authors.map(author => author.name).join(", ", last: " and ").
      #acmYear.
      #title.
      #emph(journal.nameShort)
      #acmVolume,
      #acmNumber,
      Article #acmArticle (#displayMonth(acmMonth) #acmYear),
      #counter(page).display((..nums) => [
        #nums.pos().last() page#if(nums.pos().last() > 1) { [s] }.
      ],both: true)
      https:\/\/doi.org\/#acmDOI
    ]))
    v(1pt)

    // place footer
    set text(size: 8pt)
    place(bottom, float: true)[
          #block[Authors' addresses: #{
            authors.fold((), (list, author) => {
              list + (
                [#author.name#{
                  if author.at("email", default: none) != none [, #author.email]
                  
                }]
              ,)
            }).join("; ", last: ".")
          }]
          #v(1em)

          Permission to make digital or hard copies of all or part of this
          work for personal or classroom use is granted without fee provided
          that copies are not made or distributed for profit or commercial
          advantage and that copies bear this notice and the full citation on
          the first page. Copyrights for components of this work owned by
          others than ACM must be honored. Abstracting with credit is
          permitted. To copy otherwise, or republish, to post on servers or to
          redistribute to lists, requires prior specific permission
          and#h(.5pt)/or  a fee. Request permissions from
          permissions\@acm.org.\
          #sym.copyright #acmYear Association for Computing Machinery\
          0004-5411/2018/8-ART1 \$15.00\
          https:\/\/doi.org\/#acmDOI
        ]
  }

  set heading(numbering: (..n) => [#n.pos().first()~~~])
  show heading: it => {
    set text(font: sfFont, size: 10pt, weight: "bold")
    upper(it)
    v(9pt - 0.555em)
  }

  set par(
    justify: true,
    leading: 5.35pt,
    first-line-indent: 9.5pt,
    spacing: 5.35pt)
  // show par: set block(below: 5.35pt)

  // set page(
  //   margin: (
  //     top: 58pt + 27pt,
  //     bottom: 39pt + 24pt,
  //     left: 46pt,
  //     right: 46pt
  //   ),
  // )

  // Display content
  body

  // [
  // #locate( loc => { let x = 39pt + 24pt; type(x) })

  // #locate( loc => 39pt + 24pt)
  // ]
}