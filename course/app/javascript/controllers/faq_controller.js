import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "content", "icon"]

  toggle(event) {
    const clickedItem = event.currentTarget.closest('[data-faq-target="item"]')
    const content = clickedItem.querySelector('[data-faq-target="content"]')
    const icon = clickedItem.querySelector('[data-faq-target="icon"]')
    
    // Closed other items if needed (optional, depends on UX preference)
    this.itemTargets.forEach(item => {
      if (item !== clickedItem) {
        const itemContent = item.querySelector('[data-faq-target="content"]')
        const itemIcon = item.querySelector('[data-faq-target="icon"]')
        itemContent.classList.add('hidden')
        itemContent.style.maxHeight = null
        itemIcon.style.transform = 'rotate(0deg)'
        item.classList.remove('active-faq')
      }
    })

    // Toggle current item
    const isHidden = content.classList.contains('hidden')
    
    if (isHidden) {
      content.classList.remove('hidden')
      content.style.maxHeight = content.scrollHeight + "px"
      icon.style.transform = 'rotate(180deg)'
      clickedItem.classList.add('active-faq')
    } else {
      content.classList.add('hidden')
      content.style.maxHeight = null
      icon.style.transform = 'rotate(0deg)'
      clickedItem.classList.remove('active-faq')
    }
  }
}
