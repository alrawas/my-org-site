;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "
<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">
<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>
<link href=\"https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&display=swap\" rel=\"stylesheet\">
<link rel=\"icon\" href=\"data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>&#x1f4bb;</text></svg>\">
<style>
  :root {
    --accent: #c47f30;
    --accent-hover: #a8681e;
    --bg: #faf6f0;
    --text: #3b2f1e;
    --border: #d9cbb8;
    --code-bg: #f0e8da;
    --card-bg: #fff8ee;
  }

  @media (prefers-color-scheme: dark) {
    :root {
      --bg: #1a1510;
      --text: #e0d5c5;
      --border: #3a3228;
      --code-bg: #231e17;
      --card-bg: #231e17;
      --accent: #d4944a;
      --accent-hover: #e8a85e;
    }
  }

  body {
    font-family: 'JetBrains Mono', monospace;
    background: var(--bg);
    color: var(--text);
  }

  h1, h2, h3, h4, h5, h6 {
    font-family: 'JetBrains Mono', monospace;
    letter-spacing: -0.02em;
  }

  a {
    color: var(--accent);
  }

  a:hover {
    color: var(--accent-hover);
    text-decoration: underline;
  }

  code, pre, .src {
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.9em;
  }

  pre {
    background: var(--code-bg);
    border-left: 3px solid var(--accent);
    border-radius: 4px;
    padding: 1em;
    overflow-x: auto;
  }

  header {
    border-bottom: 1px solid var(--border);
    padding-bottom: 1em;
  }

  header h1 {
    color: var(--accent);
  }

  footer {
    border-top: 1px solid var(--border);
    opacity: 0.7;
    font-size: 0.85em;
  }

  #table-of-contents {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 1em 1.5em;
    margin-bottom: 2em;
  }

  #table-of-contents h2 {
    font-size: 0.9em;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    opacity: 0.6;
    margin-top: 0;
  }

  ::selection {
    background: var(--accent);
    color: var(--bg);
  }

  /* CRT scanline overlay */
  body::after {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 9999;
    background: repeating-linear-gradient(
      0deg,
      rgba(0, 0, 0, 0.03) 0px,
      rgba(0, 0, 0, 0.03) 1px,
      transparent 1px,
      transparent 3px
    );
  }

  /* Screen edge vignette */
  body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 9998;
    box-shadow: inset 0 0 120px rgba(0, 0, 0, 0.25);
  }

  /* Subtle screen flicker */
  @keyframes flicker {
    0%   { opacity: 0.97; }
    5%   { opacity: 0.95; }
    10%  { opacity: 0.98; }
    15%  { opacity: 0.96; }
    20%  { opacity: 0.99; }
    100% { opacity: 0.98; }
  }

  body {
    animation: flicker 4s infinite;
  }

  /* Slight text glow for that phosphor feel */
  @media (prefers-color-scheme: dark) {
    body {
      text-shadow: 0 0 2px rgba(224, 213, 197, 0.15);
    }
    header h1 {
      text-shadow: 0 0 8px rgba(212, 148, 74, 0.3);
    }
  }
</style>
")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
