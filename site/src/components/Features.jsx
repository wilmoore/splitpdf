import './Features.css'

const FEATURES = [
  {
    title: 'Finder-native',
    description: 'Works directly from the right-click menu. No app window to manage.',
    icon: <FinderIcon />,
  },
  {
    title: 'Local-only',
    description: 'Your files never leave your machine. No uploads, ever.',
    icon: <LockIcon />,
  },
  {
    title: 'Fast',
    description: 'Splits complete in under 2 seconds. No waiting.',
    icon: <BoltIcon />,
  },
  {
    title: 'Zero config',
    description: 'No setup required. Install once and forget.',
    icon: <SparkleIcon />,
  },
]

export default function Features() {
  return (
    <section className="features bg-alt">
      <div className="container">
        <h2 className="text-center">Why PDF Pages?</h2>
        <div className="features__grid">
          {FEATURES.map((feature) => (
            <div key={feature.title} className="feature">
              <div className="feature__icon">{feature.icon}</div>
              <h3 className="feature__title">{feature.title}</h3>
              <p className="feature__description">{feature.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}

function FinderIcon() {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <rect x="2" y="3" width="20" height="18" rx="2" />
      <path d="M2 8h20" />
      <path d="M6 6h.01" />
      <path d="M10 6h.01" />
    </svg>
  )
}

function LockIcon() {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <rect x="3" y="11" width="18" height="11" rx="2" />
      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
    </svg>
  )
}

function BoltIcon() {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M13 2 3 14h9l-1 8 10-12h-9l1-8z" />
    </svg>
  )
}

function SparkleIcon() {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 3v1m0 16v1m-8-9H3m18 0h-1m-2.636-6.364-.707.707M6.343 17.657l-.707.707m0-12.728.707.707m11.314 11.314.707.707" />
      <circle cx="12" cy="12" r="4" />
    </svg>
  )
}
