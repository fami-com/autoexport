(defpackage :autoexport
  (:use :cl)
  (:export :pub)
  (:local-nicknames (:ax :alexandria)))

(in-package :autoexport)

(defmacro pub (what name &body body)
  (eval-when (:compile-toplevel
              :load-toplevel
              :execute)
    (ax:with-gensyms (class slot slot-name readers reader writers writer)
      `(progn
         (,what ,name ,@body)
         ,@(when (eq what 'defclass)
            `((let ((,class (find-class ',name)))
                (c2mop:ensure-finalized ,class)
                (loop for ,slot in (c2mop:class-direct-slots ,class)
                   for ,slot-name = (c2mop:slot-definition-name ,slot)
                   for ,readers = (c2mop:slot-definition-readers ,slot)
                   for ,writers = (c2mop:slot-definition-writers ,slot)
                   do (export ,slot-name)
                   do (loop for ,reader in ,readers do
                           (export ,reader))
                   do (loop for ,writer in ,writers do
                           (export ,writer))))))
         (export ',name)))))
