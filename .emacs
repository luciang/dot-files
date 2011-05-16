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
	    (flyspell-prog-mode)
	    (setq indent-tabs-mode t)
	    (c-set-style "linux-tabs-only")))


(eval-after-load "ispell"
      (setq ispell-dictionary "english"))
(setq-default ispell-program-name "aspell")

;(flyspell-prog-mode)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . flyspell-mode))


; disable vc-git and all vc stuff (I don' use it)
(setq vc-handled-backends 'nil)



;; ========== Enable Line and Column Numbering ==========
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)
