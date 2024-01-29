import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["modalBackground", "content", "container"]

    initialize() {
        this.modalClasses = ['z-50', 'absolute', 'left-1/2', '-translate-y-1/2', 'transform', '-translate-x-1/2', 'bg-white', 'border-solid', 'border', 'duration-300', 'ease-in-out', 'rounded', 'top-1/3', 'px-8', 'py-12', 'w-9/12']
        this.backdropClasses = ['fixed', 'top-0', 'left-0', 'w-full', 'h-full', 'bg-black', 'bg-opacity-20']
    }

    open() {
        const modal = document.getElementById('modal');
        modal.classList.add(...this.modalClasses)
        this.modalBackgroundTarget.classList.add(...this.backdropClasses);
    }

    hide() {
        const content = this.contentTarget;
        const turbo = this.contentTarget.parentElement;
        const modal = document.getElementById('modal');
        modal.classList.remove(...this.modalClasses)
        this.modalBackgroundTarget.classList.remove(...this.backdropClasses);
        turbo.removeAttribute("src");
        content.remove();

    }
}