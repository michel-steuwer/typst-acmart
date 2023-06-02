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

  // Configure the page.
  set page(
    width:  6.75in,
    height: 10in,
    margin: (
      top: 58pt + 27pt,
      bottom: 39pt + 24pt,
      left: 46pt,
      right: 46pt
    ),
    header: locate(loc => {
      set text(size: 8pt, font: sfFont)
      let currentpage = loc.page()
      if currentpage == 1 {
        
      } else  {
        let acmArticlePage = [#acmArticle:#counter(page).display()]
        block(
          fill: gray,
          height: 13pt,
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
      }
    }),
    header-ascent: 0%,
    footer: locate(loc => {
      set text(size: 8pt)
      let currentpage = loc.page()
      if currentpage == 1 {
        
      } else  {
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
            align(left, currentfooting)
           } else {
            align(right, currentfooting)
           }
        )
      }
    }),
    footer-descent: 0%,
  )

  set text(font: mainFont, size: 10pt)
  set par(justify: true)

  set heading(numbering: "1")
  show heading: it => {
    set text(font: sfFont, size: 10pt, weight: "bold")
    upper(it)
  }

  // Display title
  {
    set text(font: sfFont, size: 14.4pt, weight: "bold")
    par(title)
  }

  // Display authors
  {
    let displayAuthor(author) = [#text(font: sfFont, size: 12pt, upper(author.name))]
    let displayAuthors(authors) = authors.map(displayAuthor).join(", ", last: " and ")

    let displayAffiliation(affiliation) = [,#text(font: mainFont, size: 9pt)[
      #affiliation.institution, #affiliation.country]\
    ]
    par(leading: 0.5em,{
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
  }

  // Display abstract
  par(leading: 0.5em, text(size: 9pt, abstract))

  // Display CSS concepts:
  par(leading: 0.5em, text(size: 9pt)[CCS Concepts: #{
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

  // Display keywords
  par(leading: 0.5em, text(size: 9pt)[
    Additional Key Words and Phrases: #keywords.join(", ")])

  // Display ACM reference format
  par(leading: 0.65em, text(size: 9pt)[
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
  ])

  set par(justify: true, first-line-indent: 0.65em)
  show par: set block(below: 0.65em)

  // Display content
  body
}