function  [B]=imNormalize(A,tones)
mn=min(A(:));mx=max(A(:));
B=(tones-1)*(A-mn)/(mx-mn);