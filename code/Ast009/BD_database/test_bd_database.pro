
;+
; NAME:
;  TEST_BD_DATABASE
;
; DESCRIPTION:
;  TEST_BD_DATABASE interactively inspects the format of the current BD database structures
;  The program saves the existing format as a IDL fits table
;
;
; MODIFICATION HISTORY:
; Written by Michael Gully-Santiago.  Created 2012 Aug 3.
;  Last modified 2013 January 27
;
;-
pro test_bd_database
;ss=tx_array_of_bd_structures()

;--------------Our Data------------------
cd, '/Users/gully/Astronomy/BD/DATABASE/'
       ;MWRFITS, ss, 'bd_database.fits'
d = mrdfits( 'bd_database.fits', 1 )
;----------------------------------------


;---------------Pascucci09---------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/pascucci09/'
;restore, "pascucci09.sav", /verbose
;
;out_name='2MASSJ'+pascucci09.field2
;n_els= n_elements(out_name)
;out_ra=dblarr(n_els)
;out_dec=dblarr(n_els)

;for i =0, n_els-1 do begin
;print, i
;  querysimbad,  out_name[i], ra, de
;  out_ra[i]=ra
;  out_dec[i]=de
;endfor
;----------------------------------------


;---------------Scholz07-----------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/scholz07/'
;restore, "scholz07.sav", /verbose
;
;
;out_name=scholz07.field01
;n_els= n_elements(out_name)
;out_ra=dblarr(n_els)
;out_dec=dblarr(n_els)
;
;for i =0, n_els-1 do begin
;print, i
;  STRINGAD, scholz07.field02[i]+'  '+scholz07.field03[i], ra1, dec1
;  out_ra[i]=ra1
;  out_dec[i]=dec1
;endfor
;----------------------------------------

;---------------Luhman06-----------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/luhman06/'
;restore, "luhman06.sav", /verbose
;----------------------------------------

;;---------------Furlan11-----------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/furlan11/'
;restore, "furlan11.sav", /verbose
;
;out_name=furlan11.field1
;n_els= n_elements(out_name)
;out_ra=dblarr(n_els)
;out_dec=dblarr(n_els)
;
;for i =0, n_els-1 do begin
;print, i
;  if i ne 161 then STRINGAD, furlan11.field2[i]+'  '+furlan11.field3[i], ra1, dec1
;  out_ra[i]=ra1
;  out_dec[i]=dec1
;endfor
;;----------------------------------------


;---------------McClure2010---------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/mcclure10/'
;;fn='apjs330182t2_ascii.txt'
;restore, "mcclure10.sav", /verbose
;
;out_name=mcclure10.field01
;
;n_els= n_elements(out_name)
;out_ra=dblarr(n_els)
;out_dec=dblarr(n_els)

;for i =0, n_els-1 do begin
;print, i
;  ra1=0.0
;  dec1=0.0
;  id=where(mcclure10.field01[i] eq mcclure10t1.field01 or $
;           mcclure10.field01[i] eq mcclure10t1.field02)
;  if id[0] ne -1 then begin
;    STRINGAD, mcclure10t1.field04[i]+'  '+mcclure10t1.field05[i], ra1, dec1
;  endif else begin
;    querysimbad,  mcclure10.field01[i], ra1, dec1
;  endelse
;  out_ra[i]=ra1
;  out_dec[i]=dec1
;endfor

;;use the hand-editted version
;readcol, 'temp_radec.txt', out_ra, out_dec, format='F,F'
;----------------------------------------



;---------------Harvey2012---------------
;cd, '/Users/gully/Astronomy/BD/LIT_DATA/harvey12/'
;;fn='apj435378t3_ascii.txt'
;restore, "harvey12.sav", /verbose
;
;;Read in the lord list of ra and dec's 
;readcol, 'lord_list_radec.txt', out_ra, out_dec, format='F,F'
;
;n_els= n_elements(out_ra)
;h70=replicate('NaN', n_els,2)
;h160=[[replicate('NaN', n_els)], [replicate('NaN', n_els)], [replicate('null', n_els)]]
;
;out_name=harvey12.field1
;nh=n_elements(out_name)
;hc=fltarr(nh, 2)
;
;
;for i=0, nh-1 do begin
;  ;parse the ra and dec into decimal degrees.
;  if STRPOS( harvey12.field2[i], '-' ) ne -1 then strs = [STRSPLIT( harvey12.field2[i], '-', /EXTRACT), '-']
;  if STRPOS( harvey12.field2[i], '+' ) ne -1 then strs = [STRSPLIT( harvey12.field2[i], '+', /EXTRACT), '+']
;  ra_dec=strs[0]+' '+strs[2]+strs[1]
;  stringad, ra_dec, ra1, dec1
;  hc[i, *]=[ra1, dec1]
;endfor
;
;
;for i=0, n_els-1 do begin
;  dist1=SQRT((out_ra[i]-hc[*, 0])^2+(out_dec[i]-hc[*, 1])^2)
;  id=sort(dist1)
;  
;  if dist1[id[0]]*3600.0 lt 4.0 then begin 
;    if STRPOS( harvey12.field5[id[0]], '+or-' ) ne -1 then strs = STRSPLIT( harvey12.field5[id[0]], '+or-', /EXTRACT)
;    if STRPOS( harvey12.field5[id[0]], '<' ) ne -1 then strs = [STRSPLIT( harvey12.field5[id[0]], '<', /EXTRACT), 0.0]
;    h70[i, *]=strs
;    
;    strs=[0, 0]
;    if STRPOS( harvey12.field6[id[0]], '+or-' ) ne -1 then strs = STRSPLIT( harvey12.field6[id[0]], '+or-', /EXTRACT)
;    if STRPOS( harvey12.field6[id[0]], '<' ) ne -1 then strs = [STRSPLIT( harvey12.field6[id[0]], '<', /EXTRACT), 0.0]
;    h160[i, *]=[strcompress(strs[0], /remove_all),strcompress(strs[1], /remove_all), 'Harv12']
;  endif
;  
;endfor
;----------------------------------------

;;---------------Catarina 2013-----------------
cd, '/Users/gully/Astronomy/BD/LIT_DATA/catarina2013/'
restore, "catarina2013.sav", /verbose ;contains nm1, ra1, dec1

out_name=nm1
n_els= n_elements(out_name)
out_ra=double(ra1)
out_dec=double(dec1)
;;----------------------------------------



print, 1
;*catalogs:
;fp_psc 2MASSAll-SkyPointSourceCatalog(PSC)
;           1  fp_psc  2MASSAll-SkyPointSourceCatalog(PSC)
;          61  slphotdr2  SpitzerEnhancedImagingSourceList
;          62  slicov  SpitzerEnhancedImagingIRACCoverageTable
;          63  slmcov  SpitzerEnhancedImagingMIPSCoverageTable
;          64  slsm  SpitzerEnhancedImagingSuperMosaicTable
;          65  slaorpidsmid  SpitzerEnhancedImagingAORPIDSMIDTable
;          68  irs_enhv211  IRSEnhancedProducts
;          71  dr4_clouds_full  C2DFall'07FullCLOUDSCatalog(CHA_II,LUP,OPH,PER,SER)
;          72  dr4_clouds_hrel  C2DFall'07HighReliability(HREL)CLOUDSCatalog(CHA_II,LUP,OPH,PER,SER)
;          73  dr4_clouds_ysoc  C2DFall'07candidateYoungStellarObjects(YSO)CLOUDSCatalog(CHA_II,LUP,OPH,PER,SER)
;          74  dr4_off_cloud_full  C2DFall'07FullOFF-CLOUDCatalog(CHA_II,LUP,OPH,PER,SER)
;          75  dr4_off_cloud_hrel  C2DFall'07HighReliability(HREL)OFF-CLOUDCatalog(CHA_II,LUP,OPH,PER,SER)
;          76  dr4_off_cloud_ysoc  C2DFall'07candidateYoungStellarObjects(YSO)OFF-CLOUDCatalog(CHA_II,LUP,OPH,PER,SER)
;          266  wise_allsky_4band_p3as_psd  WISEAll-SkySourceCatalog

;*******************
;******2MASS********
;*******************
print, '------------'

;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=query_irsa_cat(vec, catalog='fp_psc', radius=30.0, radunits='arcsec')
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.ra)*3600.0)^2.0+((vec[1]-t.dec)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 3.0 then forprint, t.J_M[i], t.J_CMSIG[i], ' Cutr03 ', t.H_M[i], t.H_CMSIG[i], ' Cutr03 ', t.K_M[i], t.K_CMSIG[i], sep[i], textout=1
;    if sep[i] ge 3.0 then forprint, ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', sep[i], textout=1
;  endif else begin
;    forprint, ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' sep ', textout=1
;  endelse
;endfor


;*******************
;******DENIS*********
;*******************
;print, '------------'
;
;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=QUERYVIZIER2('B/denis', vec, 1.0, /SILENT)
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.raj2000)*3600.0)^2.0+((vec[1]-t.DEJ2000)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 3.0 then forprint, t[i].IMAG, t[i].E_IMAG,t[i].JMAG, t[i].E_JMAG,$
;    t[i].KMAG, t[i].E_KMAG, sep[i], textout=1
;    if sep[i] ge 3.0 then forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', sep[i], textout=1
;  endif else begin
;    forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', ' NaN ', textout=1
;  endelse
;endfor


;*******************
;******UKIDSS*********
;*******************
print, '------------'

;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=QUERYVIZIER2('II/310', vec, 1.0, /SILENT)
;  if DATATYPE(t) ne 'STC' then t=QUERYVIZIER2('II/304', vec, 1.0, /SILENT) 
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.raj2000)*3600.0)^2.0+((vec[1]-t.DEJ2000)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 3.0 then stop
;    if sep[i] ge 3.0 then stop
;  endif else begin
;    forprint, ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ',$
;    ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', textout=1 
;  endelse
;endfor



;*******************
;******SDSS*********
;*******************
print, '------------'

;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=QUERYVIZIER2('II/306', vec, 1.0, /SILENT)
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.raj2000)*3600.0)^2.0+((vec[1]-t.DEJ2000)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 3.0 then forprint, t[i].UMAG, t[i].E_UMAG,t[i].GMAG, t[i].E_GMAG,$
;    t[i].RMAG, t[i].E_RMAG,t[i].IMAG, t[i].E_IMAG,t[i].ZMAG, t[i].E_ZMAG, sep[i], textout=1
;    if sep[i] ge 3.0 then forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ',sep[i], textout=1
;  endif else begin
;    forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', textout=1
;  endelse
;endfor


;;*******************
;;*******WISE********
;;*******************
;print, '------------'


;THIS IS THE OLD ONE!
;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=query_irsa_cat(vec, catalog='wise_allsky_4band_p3as_psd', radius=15.0, radunits='arcsec')
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.ra)*3600.0)^2.0+((vec[1]-t.dec)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 6.0 then forprint, t.w1mpro[i], t.w1sigmpro[i], t.w2mpro[i], t.w2sigmpro[i], $
;      t.w3mpro[i], t.w3sigmpro[i], t.w4mpro[i], t.w4sigmpro[i], t.nb[i], t.na[i],$
;      '   '+t.cc_flags[i], t.ext_flg[i], '   '+t.var_flg[i], sep[i], textout=1
;    if sep[i] ge 6.0 then forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', textout=1
;  endif else begin
;    forprint, ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' NaN ', ' NaN ', ' null ', ' sep ', textout=1
;  endelse
;endfor

;THIS IS THE NEW (GOOD) ONE!
;for num= 0, n_els-1 do begin
;  ;vec=[d[num].ra[0], d[num].dec[0]]
;  vec=[out_ra[num], out_dec[num]]
;  t=QUERYVIZIER2('II/311', vec, 1.0, /SILENT)
;  if DATATYPE(t) eq 'STC' then begin
;    sep=SQRT(((vec[0]-t.raj2000)*3600.0)^2.0+((vec[1]-t.DEJ2000)*3600.0)^2.0)
;    ids=sort(sep)
;    i=ids[0]
;    if sep[i] lt 3.0 then forprint, t[i].W1MAG, t[i].E_W1MAG,t[i].W2MAG, t[i].E_W2MAG,$
;    t[i].W3MAG, t[i].E_W3MAG,t[i].W4MAG, t[i].E_W4MAG,' nb ', ' na ', t[i].ccf, t[i].ex, ' '+t[i].var, sep[i], textout=1
;    if sep[i] ge 3.0 then forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ',' NaN ', ' NaN ',' NaN ', sep[i], textout=1
;  endif else begin
;    forprint,' NaN ', ' NaN ', ' NaN ', ' NaN ',  ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ',' NaN ', ' NaN ',' NaN ', ' NaN ', textout=1
;  endelse
;endfor

;*******************
;*******c2d********
;*******************
print, '------------'
;
for num= 50, n_els-1 do begin
  ;vec=[d[num].ra[0], d[num].dec[0]]
    vec=[out_ra[num], out_dec[num]]
  t=query_irsa_cat(vec, catalog='dr4_clouds_full', radius=30.0, radunits='arcsec')
  if DATATYPE(t) eq 'STC' then begin
    sep=SQRT(((vec[0]-t.ra)*3600.0)^2.0+((vec[1]-t.dec)*3600.0)^2.0)
    ids=sort(sep)
    i=ids[0]
    if sep[i] lt 6.0 then forprint, 2.5*alog10(280900.0/t.ir1_flux_c[i]), alog10(1.0+t.ir1_d_flux_c[i]/t.ir1_flux_c[i])*2.5, $
                                    2.5*alog10(179700.0/t.ir2_flux_c[i]), alog10(1.0+t.ir2_d_flux_c[i]/t.ir2_flux_c[i])*2.5, $
                                    2.5*alog10(115000.0/t.ir3_flux_c[i]), alog10(1.0+t.ir3_d_flux_c[i]/t.ir3_flux_c[i])*2.5, $
                                    2.5*alog10(64130.0/t.ir4_flux_c[i]), alog10(1.0+t.ir4_d_flux_c[i]/t.ir4_flux_c[i])*2.5, ' ref ',$
                                    t.MP1_FLUX_C[i], t.MP1_D_FLUX_C[i],t.MP2_FLUX_C[i], t.MP2_D_FLUX_C[i], $
                                    sep[i]
    if sep[i] ge 6.0 then forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' ref ', ' NaN ', ' NaN ', sep[i]
  endif else begin
    forprint, ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' NaN ', ' ref ', ' NaN ', ' NaN ', ' sep '
  endelse
endfor


end
;print, 1
;d0='/Users/gully/Astronomy/BD/LIT_DATA/vlm-plx-data/'
;vlmplx = mrdfits( d0+'vlm-plx-all.fits', 1 )
;
;querysimbad, 'HR8799', ra1, dec1
;
;ybd=clear_struct(vlmplx)
;
;nm1=20-1
;
;ybd.name[0:nm1]=string(d.altname)
;ybd.ISPTSTR[0:nm1]=d.derived[0, 0]
;ybd.ra[0:nm1]=d.ra
;ybd.dec[0:nm1]=d.dec
;ybd.imag=d.groundphot[4, 0]
;ybd.eimag=d.groundphot[4, 1]
;ybd.j2mag=d.groundphot[5, 0]
;ybd.ej2mag=d.groundphot[5, 1]
;ybd.h2mag=d.groundphot[7, 0]
;ybd.eh2mag=d.groundphot[7, 1]
;ybd.k2mag=d.groundphot[8, 0]
;ybd.ek2mag=d.groundphot[8, 1]
;
;;   C1MAG           FLOAT     Array[365]
;;   EC1MAG          FLOAT     Array[365]
;;   C2MAG           FLOAT     Array[365]
;;   EC2MAG          FLOAT     Array[365]
;;   C3MAG           FLOAT     Array[365]
;;   EC3MAG          FLOAT     Array[365]
;;   C4MAG           FLOAT     Array[365]
;;   EC4MAG          FLOAT     Array[365]
;;   W1MAG           FLOAT     Array[365]
;;   EW1MAG          FLOAT     Array[365]
;;   W2MAG           FLOAT     Array[365]
;;   EW2MAG          FLOAT     Array[365]
;;   W3MAG           FLOAT     Array[365]
;;   EW3MAG          FLOAT     Array[365]
;;   W4MAG           FLOAT     Array[365]
;;   EW4MAG          FLOAT     Array[365]
;;   NBLFG           INT       Array[365]
;;   NAFLG           INT       Array[365]
;;   CCFLG           STRING    Array[365]
;;   EXFLG           INT       Array[365]
;;   VRFLG           STRING    Array[365]
;;   QLFLG           STRING    Array[365]
;;   IRACWISEREF     STRING    Array[365]
;;   SYSID           INT       Array[365]
;;   BINFLG          INT       Array[365]
;;   COMPSEP         FLOAT     Array[365]
;;   HSTAOFLG        STRING    Array[365]
;;   HSTAOREF        STRING    Array[365]
;
;MWRFITS, ybd, 'ybd_365.fits'

;print, 'pause'

;end