import { Controller } from "@hotwired/stimulus"
import consumer from '../channels/consumer'

export default class ScoreboardController extends Controller {
  connect() {
		consumer.subscriptions.create('ScoreboardChannel', {
			received(data) {
				window.location.reload()
			}
		});
  }
}
