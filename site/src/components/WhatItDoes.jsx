import './WhatItDoes.css'

export default function WhatItDoes() {
  return (
    <section className="what-it-does bg-alt">
      <div className="container container--narrow text-center">
        <h2>What It Does</h2>
        <p className="what-it-does__text">
          PDF Pages (Finder) is a macOS utility that splits a PDF into individual
          page files directly from Finder using a right-click action.
        </p>
        <p className="what-it-does__text what-it-does__text--emphasis">
          No app to open. No files to upload. No configuration.
        </p>
      </div>
    </section>
  )
}
