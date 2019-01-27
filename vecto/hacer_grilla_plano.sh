pdftk plano* cat output regis.pdf
pdfcrop --margins 20 regis.pdf
pdfjam regis-crop.pdf --nup 3x3 --outfile grilla_regis.pdf
pdfcrop --margins 20 grilla_regis.pdf

rm regis.pdf regis-crop.pdf grilla_regis.pdf
mv grilla_regis-crop.pdf grilla_plano.pdf
