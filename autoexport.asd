(defpackage :autoexport-system
  (:use :cl :asdf))

(in-package :autoexport-system)

(defsystem :autoexport
    :licence "BSD-3-Clause"
    :author "fami-com"
    :description "A small library to automatically export definitions"
    :serial t
    :depends-on (:closer-mop :alexandria)
    :components
    ((:file "autoexport")))
