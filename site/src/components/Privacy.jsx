import './Privacy.css'

export default function Privacy() {
  return (
    <section className="privacy">
      <div className="container container--narrow text-center">
        <div className="privacy__icon">
          <ShieldIcon />
        </div>
        <h2>Your Files Stay Private</h2>
        <p className="privacy__text">
          PDF Pages works entirely on your Mac. Your files never leave your machine.
        </p>
        <ul className="privacy__list">
          <li>
            <CheckIcon /> No uploads
          </li>
          <li>
            <CheckIcon /> No telemetry
          </li>
          <li>
            <CheckIcon /> No analytics
          </li>
          <li>
            <CheckIcon /> Works offline
          </li>
        </ul>
      </div>
    </section>
  )
}

function ShieldIcon() {
  return (
    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
      <path d="m9 12 2 2 4-4" />
    </svg>
  )
}

function CheckIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 6 9 17l-5-5" />
    </svg>
  )
}
