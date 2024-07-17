import { Controller } from "@hotwired/stimulus"

export default class RefreshController extends Controller {
	static values = {
		interval: Number
	}

  connect() {
		this.timer = setTimeout(() => {
			window.location.reload();
		}, this.intervalValue * 1000);
  }

	disconnect() {
		if (!this.timer) return;

		console.log('clearing timeout');
		clearTimeout(this.timer);
	}
}
