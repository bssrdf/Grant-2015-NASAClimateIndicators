;***********************************************
; u2-plot.ncl
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
  blobfile = addfile("ERA_blobs.nc","r")

;************************************************
; read blob id 
;************************************************
  blobid = blobfile->PV_ADEV_INTtag(43,:,:)

  do i = 0,180
  do j = 0,359
    if (blobid(i,j) .eq. 0)
	  blobid(i,j) = -1
	end if
  end do
  end do

  blobid@_FillValue = -1

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

  wks = gsn_open_wks("eps","blob_plot")   

; choose color table:
;  gsn_define_colormap(wks,"cosam12")             ; not enough colors
;  gsn_define_colormap(wks,"gui_default")
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")   ; favorite right now
;  gsn_define_colormap(wks,"BlGrYeOrReVi200")
;  gsn_define_colormap(wks,"BlueRed")              ; mid-light blue to red
;  gsn_define_colormap(wks,"BlRe")                ; too dark
;  gsn_define_colormap(wks,"wh-bl-gr-ye-re")
;  gsn_define_colormap(wks,"WhBlGrYeRe")
;  gsn_merge_colormaps(wks,"gui_default","BlueDarkRed18")

  res@cnFillOn          = True
  res@cnLinesOn         = False
  res@cnLineLabelsOn    = False
  res@lbLabelAutoStride = True
  res@cnInfoLabelOn     = False
  res@tmXBLabelsOn      = True
  res@tmXBOn            = True

  res@tmXTLabelsOn      = False
  res@tmXTOn            = False

  res@lbLabelBarOn      = False

  res@gsnSpreadColors      = True
;  res@gsnSpreadColorStart = 24
;  res@gsnSpreadColorEnd   = 41

  printMinMax(blobid, True)

  res@cnLevelSelectionMode = "ManualLevels"
  res@cnLevelSpacingF = 1.0
  res@cnMinLevelValF = 0.0
  res@cnMaxLevelValF = 191.0

  res@mpOutlineDrawOrder = "PreDraw"
  res@mpLandFillColor = "White"
  res@mpGeophysicalLineColor = "Gray"
  res@mpGeophysicalLineThicknessF = 4.0

  res@tiMainString = "Automated Atmospheric Block Detection and Tagging"
  ;res@tiYAxisString = "Latitude"
  ;res@tiXAxisString = "Longitude"

  plot(0) = gsn_csm_contour_map_ce(wks, blobid, res)

  gsres = True
  gsres@gsLineThicknessF = 0.5
  gsres@gsLineColor = 1
  gsres@gsLineDashPattern = 2

  pres = True
  pres@gsnPanelYWhiteSpacePercent = 5

  ;gsn_panel(wks, plot, (/1,1/), pres)

end
