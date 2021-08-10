(defpackage :autoexport-system
  (:use :cl :asdf))

(in-package :autoexport-system)

(defsystem :autoexport
    :serial t
    :depends-on (:closer-mop :alexandria)
    :components
    ((:file "autoexport")))
