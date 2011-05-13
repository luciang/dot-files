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




(flyspell-prog-mode)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . flyspell-mode))


; http://stackoverflow.com/questions/5748814/how-does-one-disable-vc-git-in-emacs
(remove-hook 'find-file-hooks 'vc-find-file-hook)


