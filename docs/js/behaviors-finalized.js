const behaviors = {
  "tei": {
    "choice": function(elt) {
      elt.querySelector('tei-corr').setAttribute("title", elt.querySelector('tei-sic>span[data-original]').textContent);
    },
    "date": ['',' '],
    "div": function(elt) {
      const link = document.createElement('a');
      link.setAttribute('href', `#${elt.getAttribute('id')}`);
      link.innerHTML = `${this.getOrdinality(elt)}.`;
      elt.prepend(link);
    },
    "sic": ['','(!)'],
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