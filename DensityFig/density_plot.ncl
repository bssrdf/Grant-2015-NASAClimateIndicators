;***********************************************
; density_plot.ncl
;***********************************************

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"  

;************************************************
begin

;************************************************
; read in netCDF file
;************************************************
  densityfile = addfile("climo_density.nc","r")

;************************************************
; read density
;************************************************
  density = densityfile->density

;************************************************
; plot resources [options]
;************************************************
  plot = new(1,graphic)                ; define a panel plot

; Resources:
  res                     = True

  res@gsnDraw             = True
  res@gsnFrame            = True

  res@vpKeepAspect        = True
  res@vpWidthF            = 0.8
  res@vpHeightF           = 0.4

  res@cnFillMode          = "RasterFill"
  res@cnRasterSmoothingOn = False
  res@gsnMaximize         = False

  res@tiXAxisFontHeightF  = 0.012
  res@tiYAxisFontHeightF  = 0.012

  wks = gsn_open_wks("eps","density_plot")   

; choose color table:
  gsn_define_colormap(wks,"WhiteBlue")

  res@cnFillOn          = True
  res@cnLinesOn         = False
  res@cnLineLabelsOn    = False
  res@lbLabelAutoStride = True
  res@cnInfoLabelOn     = False
  res@tmXBLabelsOn      = True
  res@tmXBOn            = True

  res@tmXTLabelsOn      = False
  res@tmXTOn            = False

  ;res@lbLabelBarOn      = False

  res@gsnSpreadColors      = True
;  res@gsnSpreadColorStart = 24
;  res@gsnSpreadColorEnd   = 41

  printMinMax(density, True)

  res@cnLevelSelectionMode = "ManualLevels"
  res@cnLevelSpacingF = 10.0
  res@cnMinLevelValF = 0.0
  res@cnMaxLevelValF = 140.0

  ;res@mpOutlineDrawOrder = "PreDraw"
  res@mpLandFillColor = "White"
  res@mpGeophysicalLineColor = "Black"
  res@mpGeophysicalLineThicknessF = 1.0

  res@tiMainString = "Extratropical Cyclone Density"
  ;res@tiYAxisString = "Latitude"
  ;res@tiXAxisString = "Longitude"

  plot(0) = gsn_csm_contour_map_ce(wks, density, res)

  gsres = True
  gsres@gsLineThicknessF = 0.5
  gsres@gsLineColor = 1
  gsres@gsLineDashPattern = 2

  pres = True
  pres@gsnPanelYWhiteSpacePercent = 5

  ;gsn_panel(wks, plot, (/1,1/), pres)

end
