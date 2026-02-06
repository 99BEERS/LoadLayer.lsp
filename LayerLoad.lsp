;; Created by Dominique Gladeau                                         

(vl-load-com)
(defun c:PELAYER()

    (setq acadObj (vlax-get-acad-object)
          doc (vla-get-ActiveDocument acadObj))
    
    ;; Create a new nonplot layer
    (setq layerObj (vla-Add (vla-get-Layers doc) "PE-Invisible")
          color (vla-get-TrueColor layerObj))
    (vla-SetRGB color 55 209 41)
    (vla-put-TrueColor layerObj color)
    (vla-put-Plottable layerObj :vlax-false)     ;; Change plottable state
   
   ;; Create new RGB layer
    (setq layerObj (vla-Add (vla-get-Layers doc) "PE-Blue")
          color (vla-get-TrueColor layerObj))
    (vla-SetRGB color 80 100 244)
    (vla-put-TrueColor layerObj color)

    (setq found :vlax-false)
    (vlax-for entry (vla-get-Linetypes doc)
        (if (= (vla-get-Name entry) "DASHDOT")
            (setq found :vlax-true)
        )
    )
  
    (if (= found :vlax-false)
        (if (/= (strcase (getvar "PROGRAM") T) "acadlt")
            (vla-Load (vla-get-Linetypes doc) "DASHDOT" "acad.lin")
            (vla-Load (vla-get-Linetypes doc) "DASHDOT" "acadlt.lin")
            (vla-Load (vla-get-Linetypes doc) "CENTER2" "acad.lin")
            (vla-Load (vla-get-Linetypes doc) "CENTER2" "acadlt.lin")
            (vla-Load (vla-get-Linetypes doc) "HIDDENX2" "acad.lin")
            (vla-Load (vla-get-Linetypes doc) "HIDDENX2" "acadlt.lin")
        )
    )

   ;; Create new Index Colour layer
    (setq layerObj (vla-Add (vla-get-Layers doc) "PE-Red"))
    (vla-put-Color layerObj 1)
    (vla-put-Linetype layerObj "DASHDOT")

   ;; Create new Index Colour layer
    (setq layerObj (vla-Add (vla-get-Layers doc) "PE-Blue"))
    (vla-put-Color layerObj 4)
    (vla-put-Linetype layerObj "CENTER2")

    ;; Make the new layer the active layer for the drawing
    (vla-put-ActiveLayer doc layerObj)
    
    (vla-Regen doc :vlax-true)
(princ)
    
)