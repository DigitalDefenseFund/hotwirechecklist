// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="draggable">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import Sortable from 'sortablejs'
import { patch } from '@rails/request.js'

export default class extends Controller {
  static targets = [ "list" ]
  static values = { url: String }

  async connect() {

    async function saveSwitch(url, data) {
      const request = await patch(url, { query: data })
      if (request.ok) {
        return true
      } else {
        return false
      }
    }

    var sortable = Sortable.create(this.listTarget, {
        onEnd: function(event) {
          const url = event.item.dataset.urlValue

          var data = new FormData
          data.append("item[position]", event.oldIndex)
          data.append("item[new_position]", event.newIndex)
          saveSwitch(url, data)
        }
      }
    )
  }

}
