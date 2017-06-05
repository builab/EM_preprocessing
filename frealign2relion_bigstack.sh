# NOTE 1.375 = pixelSize
relion_star_loopheader rlnImageName rlnMicrographName rlnDefocusU rlnDefocusV rlnDefocusAngle rlnVoltage rlnSphericalAberration rlnDetectorPixelSize rlnMagnification rlnAmplitudeContrast rlnOriginX rlnOriginY rlnAngleRot rlnAngleTilt rlnAnglePsi > all_images.star

awk '{if ($1!="C") {print $1"@Particles/ChlamyDMT_16nm_c1_bin1_stack.mrcs", $8, $9, $10, $11, " 300 2.7 14", $7, 0.1, -$5/1.395, -$6/1.395, $4, $3,$2}  }' < ChlamyDMT_16nm_c1_16_r1.par >> all_images.star
