import { Controller } from "@hotwired/stimulus"
import consumer from '../channels/consumer'

export default class ScoreboardController extends Controller {
  connect() {
		this.subscription = consumer.subscriptions.create('ScoreboardChannel', {
			received() {
				window.location.reload()
			}
		});
  }

	disconnect() {
		if (!this.subscription) return;

		consumer.subscriptions.remove(this.subscription)
	}
}
