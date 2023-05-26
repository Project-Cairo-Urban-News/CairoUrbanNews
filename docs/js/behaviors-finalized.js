const behaviors = {
  "tei": {
    "choice": function(elt) {
      const sic = elt.querySelector('tei-sic');
      const corr = elt.querySelector('tei-corr');
      corr.setAttribute("title", sic.textContent);
      corr.setAttribute("data-bs-toggle", "tooltip");
      corr.setAttribute("data-bs-custom-class", "custom-tooltip");
    },
    "date": ['',' '],
    "div": function(elt) {
      const link = document.createElement('a');
      link.setAttribute('href', `#${elt.getAttribute('id')}`);
      link.innerHTML = `${this.getOrdinality(elt)}.`;
      elt.prepend(link);
    },
    "sic": [
      [":not(tei-choice) tei-sic", ['','(!)']],
    ],
    "table": function(elt) {
      const table = document.createElement("table");
      if (elt.firstElementChild.localName == "tei-head") {
        const head = elt.firstElementChild;
        head.remove();
        const caption = document.createElement("caption");
        caption.innerHTML = head.innerHTML;
        table.appendChild(caption);
      }
      for (let row of Array.from(elt.querySelectorAll("tei-row"))) {
        const tr = document.createElement("tr");
        for (let attr of Array.from(row.attributes)) {
          tr.setAttribute(attr.name, attr.value);
        }
        for (let cell of row.children) {
          const td = document.createElement("td");
          if (cell.hasAttribute("cols")) {
            td.setAttribute("colspan", cell.getAttribute("cols"));
          }
          for (const n of cell.childNodes) {
            if (n.nodeType == Node.ELEMENT_NODE) {
              td.appendChild(this.copyAndReset(n));
            } else {
              td.appendChild(n.cloneNode());
            }
          }
          tr.appendChild(td);
        }
        table.appendChild(tr);
      }
      this.hideContent(elt, true);
      elt.appendChild(table);
    }
  }
}