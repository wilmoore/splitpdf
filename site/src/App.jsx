import Hero from './components/Hero'
import WhatItDoes from './components/WhatItDoes'
import HowItWorks from './components/HowItWorks'
import Features from './components/Features'
import Privacy from './components/Privacy'
import Install from './components/Install'
import Footer from './components/Footer'

export default function App() {
  return (
    <>
      <main>
        <Hero />
        <WhatItDoes />
        <HowItWorks />
        <Features />
        <Privacy />
        <Install />
      </main>
      <Footer />
    </>
  )
}
