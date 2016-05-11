# ! / b i n / b a s h 
 # 
 #   R u n   p r o j e c t   t e s t s 
 # 
 #   N O T E :   T h i s   s c r i p t   e x p e c t s   t o   b e   r u n   f r o m   t h e   p r o j e c t   r o o t   w i t h 
 #   . / s c r i p t s / r u n _ t e s t s . s h 
 
 #   U s e   d e f a u l t   e n v i r o n m e n t   v a r s   f o r   l o c a l h o s t   i f   n o t   a l r e a d y   s e t 
 
 s e t   - o   p i p e f a i l 
 s o u r c e   e n v i r o n m e n t . s h   2 >   / d e v / n u l l 
 
 f u n c t i o n   d i s p l a y _ r e s u l t   { 
     R E S U L T = $ 1 
     E X I T _ S T A T U S = $ 2 
     T E S T = $ 3 
 
     i f   [   $ R E S U L T   - n e   0   ] ;   t h e n 
         e c h o   - e   " \ 0 3 3 [ 3 1 m $ T E S T   f a i l e d \ 0 3 3 [ 0 m " 
         e x i t   $ E X I T _ S T A T U S 
     e l s e 
         e c h o   - e   " \ 0 3 3 [ 3 2 m $ T E S T   p a s s e d \ 0 3 3 [ 0 m " 
     f i 
 } 
 
 p e p 8   . 
 d i s p l a y _ r e s u l t   $ ?   1   " C o d e   s t y l e   c h e c k " 
 
 e x p o r t   E N V I R O N M E N T = ' m a s t e r ' 
 t e s t = $ { T E S T : = s m o k e t e s t } 
 
 #   g e t   s t a t u s   p a g e   f o r   e n v   u n d e r   t e s t s   a n d   s p i t   o u t   t o   c o n s o l e 
 f u n c t i o n   d i s p l a y _ s t a t u s   { 
     u r l = $ E N V I R O N M E N T ' _ N O T I F Y _ A D M I N _ U R L ' 
     c u r l   $ { ! u r l } / ' _ s t a t u s ' 
 } 
 
 d i s p l a y _ s t a t u s   $ E N V I R O N M E N T 
 
 e c h o   " T h i s   w i l l   b e   w h e r e   $ t e s t   h a p p e n " 
 
 #   d i s p l a y _ r e s u l t   $ ?   3   " U n i t   t e s t s " 
 