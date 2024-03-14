<script lang='js'>
  import { onMount } from "svelte";

  export let phrases = ['mastodon', 'peertube'];

  class TextScramble {
    constructor(el) {
      this.el = el
      this.chars = '!<>-_\\/[]{}—=+*^?#________'
      this.update = this.update.bind(this)
    }
    setText(newText) {
      const oldText = this.el.innerText
      const length = Math.max(oldText.length, newText.length)
      const promise = new Promise((resolve) => this.resolve = resolve)
      this.queue = []
      for (let i = 0; i < length; i++) {
        const from = oldText[i] || ''
        const to = newText[i] || ''
        const start = Math.floor(Math.random() * 40)
        const end = start + Math.floor(Math.random() * 50)
        this.queue.push({ from, to, start, end })
      }
      cancelAnimationFrame(this.frameRequest)
      this.frame = 0
      this.update()
      return promise
    }
    update() {
      let output = ''
      let complete = 0
      for (let i = 0, n = this.queue.length; i < n; i++) {
        let { from, to, start, end, char } = this.queue[i]
        if (this.frame >= end) {
          complete++
          output += to
        } else if (this.frame >= start) {
          if (!char || Math.random() < 0.28) {
            char = this.randomChar()
            this.queue[i].char = char
          }
          output += `<span class="dud">${char}</span>`
        } else {
          output += from
        }
      }
      this.el.innerHTML = output
      if (complete === this.queue.length) {
        this.resolve()
      } else {
        this.frameRequest = requestAnimationFrame(this.update)
        this.frame++
      }
    }
    randomChar() {
      return this.chars[Math.floor(Math.random() * this.chars.length)]
    }
  }

  onMount(() => {

    const el = document.querySelector('.scramble-text')
    const fx = new TextScramble(el)

    // Create an array of indices from 0 to the length of the phrases array
    // and randomise the order of the indices
    const randomisedIndices = Array.from({ length: phrases.length }, (_, i) => i)
      .sort(() => Math.random() - 0.5)

    let counter = 0
    const next = () => {
      fx.setText(phrases[randomisedIndices[counter]]).then(() => {
        setTimeout(next, 5000)
      })
      counter = (counter + 1) % phrases.length
    }

    next()
  });

</script>
<span class="scramble-text"></span>