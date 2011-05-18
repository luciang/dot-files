;; ========== Documentation/CodingStyle ==========
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
	    (setq indent-tabs-mode t)
	    (c-set-style "linux-tabs-only")))


;; ========== Generic ==========
; just testing this: if nil, the word and the expansion must match in case
(setq dabbrev-case-fold-search nil)
; just testing this:
; - if nil, the expansion is always copied verbatim;
; - if it is t, the abbrev's case pattern is preserved in most cases.
; - if dabbrev-case-replace is case-replace, which is true by default, then the
;   variable case-replace controls whether to copy the expansion verbatim
(setq dabbrev-case-replace nil)


;; ========== Flyspell ==========
;; use aspell (Ubuntu default) instead of ispell and english
(eval-after-load "ispell" (setq ispell-dictionary "english"))
(setq-default ispell-program-name "aspell")
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . flyspell-mode))



;; ========== C ==========
(add-hook 'c-mode-hook
          (lambda ()
	    (which-func-mode t) ; show the current function
	    (flyspell-prog-mode) ; spell check comments and strings
))


;; ========== VC ==========
; disable vc-git and all vc stuff (I don' use it and slows up kernel work)
(setq vc-handled-backends 'nil)



;; ========== Enable Line and Column Numbering ==========
(line-number-mode 1)
(column-number-mode 1)



;; ========== cscope ==========
(require 'xcscope)
(setq cscope-do-not-update-database t)

