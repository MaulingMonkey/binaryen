;; Test a trivial recursive type works properly

;; RUN: wasm-opt %s -all -S -o - | filecheck %s

;; TODO: Fix the bug where self-referential function signatures are emitted
;; twice. This happens because collectHeapTypes has to reconstruct a HeapType
;; from each function's signature, but self-referential HeapTypes aren't
;; canonicalized when they are parsed so collectHeapTypes ends up with a
;; separate, unfolded version of the type.

;; TODO: Fix the bug where structurally identical types are given the same
;; generated name, making the wast invalid due to duplicate names.

;; CHECK:      (module
;; CHECK-NEXT:   (type $ref?|...0|_=>_ref?|...0| (func (param (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))))
;; CHECK-NEXT:   (type $ref?|...0|_=>_ref?|...0| (func (param (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))))
;; CHECK-NEXT:   (type $ref?|ref?|...0|_->_ref?|...0||_=>_ref?|ref?|...0|_->_ref?|...0|| (func (param (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))))
;; CHECK-NEXT:   (type $ref?|ref?|...0|_->_ref?|...0||_=>_ref?|ref?|...0|_->_ref?|...0|| (func (param (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))))
;; CHECK-NEXT:   (func $foo (param $0 (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))
;; CHECK-NEXT:     (unreachable)
;; CHECK-NEXT:   )
;; CHECK-NEXT:   (func $bar (param $0 (ref null $ref?|...0|_=>_ref?|...0|)) (result (ref null $ref?|...0|_=>_ref?|...0|))
;; CHECK-NEXT:     (unreachable)
;; CHECK-NEXT:   )
;; CHECK-NEXT: )

(module
  (type (func (param (ref null 0)) (result (ref null 0))))
  (type (func (param (ref null 1)) (result (ref null 1))))
  (func $foo (type 0)
    (unreachable)
  )
  (func $bar (type 1)
    (unreachable)
  )
)
