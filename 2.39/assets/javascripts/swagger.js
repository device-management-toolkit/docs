// Renders Swagger UI into any element with a data-swagger-url attribute.
// Exact version with SRI hashes, so a CDN change cannot alter the published site.
const SWAGGER_UI_DIST = "https://unpkg.com/swagger-ui-dist@5.33.0"
const SWAGGER_UI_CSS_INTEGRITY = "sha384-Ov4/wv3j2bmct8cDc5X4ngJZohVPzEmc6uDPH8WeljUxO5vtoykvMEfbu9Vh6RaW"
const SWAGGER_UI_JS_INTEGRITY = "sha384-YDALVcy8kj8yltLBVi1vBiBAUqdxvus673gM8XKwiy6aDUJFXivF/KCufekjYbVf"

let swaggerUiLoaded

function loadSwaggerUi() {
  // Instant navigation swaps <head> contents, so the stylesheet is re-added per page.
  if (!document.querySelector("link[data-swagger-ui]")) {
    const css = document.createElement("link")
    css.rel = "stylesheet"
    css.href = `${SWAGGER_UI_DIST}/swagger-ui.css`
    css.integrity = SWAGGER_UI_CSS_INTEGRITY
    css.crossOrigin = "anonymous"
    css.dataset.swaggerUi = ""
    document.head.appendChild(css)
  }

  if (!swaggerUiLoaded) {
    swaggerUiLoaded = new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = `${SWAGGER_UI_DIST}/swagger-ui-bundle.js`
      script.integrity = SWAGGER_UI_JS_INTEGRITY
      script.crossOrigin = "anonymous"
      script.onload = resolve
      script.onerror = reject
      document.head.appendChild(script)
    })
  }
  return swaggerUiLoaded
}

// document$ emits on every page load, including instant navigation.
document$.subscribe(() => {
  const targets = document.querySelectorAll("[data-swagger-url]")
  if (targets.length === 0) return

  loadSwaggerUi().then(() => {
    targets.forEach((target) => {
      SwaggerUIBundle({ url: target.dataset.swaggerUrl, domNode: target })
    })
  })
})
