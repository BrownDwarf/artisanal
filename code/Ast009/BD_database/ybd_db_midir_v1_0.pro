pro ybd_db_midIR_v1_0
;Author: gully
;Date: Aug 23, 2012
;Desc: Analyze the YBD data from the database

;goals:
;0) Read all the data in
;1) Make SEDs for everything
;2) Connect in the IRS data
;3) Add more data in if it is available
;4) Go through the list of analysis strategies we had come up with

cd, '/Users/gully/Astronomy/BD/DATABASE/'
restore, filename='at.sav', /verbose
at.fieldtypes[101]=4
at.fieldtypes[84]=4
at.fieldtypes[86]=4
at.fieldtypes[89]=4
at.fieldtypes[91]=4

;fn='ybd-vlms-db_jan2013.txt' ;This file is broken
fn='ybd-vlms-db_nov2012.txt' ;This file works fine!
d=read_ascii(fn, template=at)

n_els=n_elements(d.field001)

;Make the SEDs:
;get a subset of young objects


;Make 2mJHK + MKO-ZYJHKLM + SDSS ugriz + WISE 1234 + IRAC1234 + MIPS12 + H12 SEDs
;that is 3 + 7 + 5 + 4 + 4 + 2 + 2 = 
;References: wavelengths, A_lam/Av, and Zeropoints are from 
;                                 ADPS, for M2 spectra when available, or 
;                                 Ast. Quantities, Ch 7- Tokunaga, or
;                                 P. C. Hewett et al. 2006 (UKIRT) table 7, or  
;                                 Jarrett et al. 2011 (WISE), or
;
nw=27
wl=[1.24, 1.65, 2.16, 0.88, 1.02, 1.25, 1.63, 2.19, 3.73, 4.68, 0.364, 0.50, 0.63, 0.773, 0.91,$
3.35, 4.60, 11.56,22.08, 3.6, 4.5, 5.8, 8.0, 24.0, 70.0, 70.0, 160.0]
Al_Av=[0.27, 0.17, 0.12, 0.0, 0.0, 0.26, 0.17, 0.12, 0.06, 0.04, 1.61,1.19,0.83,0.61,0.45,$
0.45*0.12,0.3*0.12,0.5*0.12,0.8*0.12, 0.45*0.12,0.3*0.12,0.31*0.12,0.25*0.12, 0.8*0.12, 0.0, 0.0, 0.0]
zp=[1594.0, 1024.0, 666.7, 2232.0, 2026.0, 1530.0, 1019.0, 631.0, 248.0, 160.0, $
0.0,0.0,0.0,0.0,0.0,$
309.54,171.78,31.674,8.363, 280.9,179.7,115.0,64.13, 0.0, 0.0, 0.0, 0.0]
sd=fltarr(n_els, nw)

sd[*, 0]=d.field021
sd[*, 1]=d.field024
sd[*, 2]=d.field027
sd[*, 3]=d.field030
sd[*, 4]=d.field033
sd[*, 5]=d.field036
sd[*, 6]=d.field039
sd[*, 7]=d.field042
sd[*, 8]=d.field045
sd[*, 9]=d.field048
sd[*, 10]=d.field051
sd[*, 11]=d.field053
sd[*, 12]=d.field055
sd[*, 13]=d.field057
sd[*, 14]=d.field059
sd[*, 15]=d.field062
sd[*, 16]=d.field064
sd[*, 17]=d.field066
w3_flag=d.field066*0.0
sd[*, 18]=d.field068
sd[*, 19]=d.field076
sd[*, 20]=d.field078
sd[*, 21]=d.field080
sd[*, 22]=d.field082
sd[*, 23]=d.field085
sd[*, 24]=d.field087
sd[*, 25]=d.field090
sd[*, 26]=d.field092

Av=d.field102
gAv= where( finite(av), complement=bav)
Av[Bav]=0.0
Av=Av*0.0

;---------POSTSCRIPT----------  
;device, decomposed=0
loadct, 13

cd, '/Users/gully/Astronomy/BD/'
outname='multiSED.eps'
psObject = Obj_New("FSC_PSConfig", /Color, /Times, /Bold, /Encapsulate, Filename=outname, xsize=4.0, ysize=4.0)
thisDevice = !D.Name
Set_Plot, "PS"
Device, _Extra=psObject->GetKeywords()
!p.thick=4.0
!x.thick=4.0
!y.thick=4.0
!z.thick=4.0

!p.font=0

xtit=greek('lambda', /append_font)+ ' ('+greek('mu', /append_font)+ 'm)'
ytit=greek('nu', /append_font)+ 'F!D'+greek('nu', /append_font)+'!N (normalized at H)'

plot, [0, 1], [0, 1], psym=5, /xlog, /ylog, xrange=[0.4, 200.0], $
yrange=[0.0001, 5.0], xstyle=1, ystyle=1, background='FFFFFF'xL, $
color='000000'xL, xtitle=xtit, ytitle=ytit, charthick=4.0,/nodata

rl=indgen(n_els)

g=where( (strpos(d.field004, 'young') ne -1) and $
          (d.field003 ge 6.0 and d.field003 lt 10.0) and $
          (rl lt 259 or rl gt 259+20) )

ng=n_elements(g)
for k=0, ng-1 do begin
kk=g[k]

this_sed=0.0*zp
;this_sed[0:22]=zp*10.0^(-1.0*sd[kk, 0:22]/2.5)  ;observed fluxes
this_sed[0:22]=zp*10.0^(-1.0*(sd[kk, 0:22]-Av[kk]*Al_Av[0:22])/2.5)
this_sed[23:26]=sd[kk, 23:26]/1000.0*10.0^(1.0*(Av[kk]*Al_Av[23:26])/2.5)
nufnu=3.0E14/wl*this_sed
nfl= nufnu/nufnu[1];normalized [This assumes there is an H band measurement]
f=where(finite(nufnu) and nufnu gt 0.0)
if f[0] ne -1 then begin
wl2=wl[f]
nf2=nfl[f]
endif 
if f[0] eq -1 then begin
wl2=[1.0, 2.0]
nf2=[0.0, 0.0]
endif 

s=sort(wl2)
wls=wl2[s]
sed=nf2[s]
loadct, 0

oplot, wls, sed, color=225, psym=5, thick=0.4, symsize=0.2
oplot, wls, sed, color='000000'xL, psym=5, symsize=0.2, thick=0.4
w3id=where(wls eq 11.56)
w4id=where(wls eq 22.08)

plotsym, 1, 0.4, thick=1
if finite(d.field066[kk]) and not finite(d.field067[kk]) then plots, wls[w3id], sed[w3id], psym=8, color=0
if finite(d.field068[kk]) and not finite(d.field069[kk]) then plots, wls[w4id], sed[w4id], psym=8, color=0

endfor
loadct, 13

;black body
bb1=blackbody(wl*10000.0, 2600, /retfnu)
bbnfn=3.0E14/wl*bb1
bn=bbnfn/bbnfn[1]
s=sort(wl)
oplot, wl[s], bn[s], linestyle=1
nb=bn
bb1=blackbody(wl*10000.0, 1400, /retfnu)
bbnfn=3.0E14/wl*bb1
bn=bbnfn/bbnfn[1]*0.2
s=sort(wl)
oplot, wl[s], bn[s], linestyle=1
nb=nb+bn
bb1=blackbody(wl*10000.0, 200, /retfnu)
bbnfn=3.0E14/wl*bb1
bn=bbnfn/bbnfn[18]*0.5
s=sort(wl)
oplot, wl[s], bn[s], linestyle=1
nb=nb+bn
nb=nb/nb[1]
oplot, wl[s], nb[s], linestyle=3, color=255


sharpcorners, thick=4.0
Device, /Close_File
Set_Plot, thisDevice
Obj_Destroy, psObject

print, '1'

end
