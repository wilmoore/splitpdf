import './HowItWorks.css'

const STEPS = [
  {
    number: '1',
    title: 'Right-click',
    description: 'Select any PDF file in Finder',
    icon: <ClickIcon />,
  },
  {
    number: '2',
    title: 'Split into Pages',
    description: 'Choose "Split into Pages" from the menu',
    icon: <MenuIcon />,
  },
  {
    number: '3',
    title: 'Done',
    description: 'Each page appears in a folder next to your file',
    icon: <CheckIcon />,
  },
]

export default function HowItWorks() {
  return (
    <section className="how-it-works">
      <div className="container">
        <h2 className="text-center">How It Works</h2>
        <div className="how-it-works__steps">
          {STEPS.map((step) => (
            <div key={step.number} className="step">
              <div className="step__icon">{step.icon}</div>
              <div className="step__number">{step.number}</div>
              <h3 className="step__title">{step.title}</h3>
              <p className="step__description">{step.description}</p>
            </div>
          ))}
        </div>
        <div className="how-it-works__screenshot">
          <img
            src="/assets/screenshot-context-menu.png"
            alt="Finder context menu showing Split into Pages option"
          />
        </div>
      </div>
    </section>
  )
}

function ClickIcon() {
  return (
    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 9V4.5a2.5 2.5 0 0 1 5 0V9" />
      <path d="M4 12v0a4 4 0 0 1 4-4h8a4 4 0 0 1 4 4v4a8 8 0 0 1-8 8v0a8 8 0 0 1-8-8v-4Z" />
    </svg>
  )
}

function MenuIcon() {
  return (
    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <rect x="3" y="3" width="18" height="18" rx="2" />
      <path d="M9 9h6" />
      <path d="M9 13h6" />
      <path d="M9 17h4" />
    </svg>
  )
}

function CheckIcon() {
  return (
    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 6 9 17l-5-5" />
    </svg>
  )
}
