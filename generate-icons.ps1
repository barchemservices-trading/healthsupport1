Add-Type -AssemblyName System.Drawing

function Create-VitalisIcon {
    param(
        [int]$size, 
        [string]$path, 
        [bool]$maskable = $false
    )
    $bmp = New-Object System.Drawing.Bitmap($size, $size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    # Dark background
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 10, 12, 16))
    if ($maskable) {
        $g.FillRectangle($bgBrush, 0, 0, $size, $size)
    } else {
        $cornerRadius = $size * 0.22
        $pathRect = New-Object System.Drawing.Drawing2D.GraphicsPath
        $d = $cornerRadius * 2
        $pathRect.AddArc(0, 0, $d, $d, 180, 90)
        $pathRect.AddArc($size - $d, 0, $d, $d, 270, 90)
        $pathRect.AddArc($size - $d, $size - $d, $d, $d, 0, 90)
        $pathRect.AddArc(0, $size - $d, $d, $d, 90, 90)
        $pathRect.CloseFigure()
        $g.FillPath($bgBrush, $pathRect)
        
        $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 255, 30, 39), [float]($size * 0.015))
        $g.DrawPath($borderPen, $pathRect)
        $borderPen.Dispose()
        $pathRect.Dispose()
    }
    $bgBrush.Dispose()

    # Red warrior gradient heart
    $scale = if ($maskable) { 0.72 } else { 0.88 }
    $cx = [float]($size / 2.0)
    $cy = [float]($size / 2.0)
    
    # Glow orb
    $glowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(45, 255, 30, 39))
    $glowRadius = [float]($size * 0.38 * $scale)
    $g.FillEllipse($glowBrush, [float]($cx - $glowRadius), [float]($cy - $glowRadius), [float]($glowRadius * 2), [float]($glowRadius * 2))
    $glowBrush.Dispose()

    # Heart dimensions
    $hW = [float]($size * 0.38 * $scale)
    $hH = [float]($size * 0.36 * $scale)
    $topY = [float]($cy - $hH * 0.8)
    $botY = [float]($cy + $hH * 0.75)

    $heartPath = New-Object System.Drawing.Drawing2D.GraphicsPath
    $heartPath.AddBezier([float]$cx, [float]($topY + $hH * 0.3), [float]($cx - $hW * 0.7), [float]($topY - $hH * 0.4), [float]($cx - $hW * 1.05), [float]($topY + $hH * 0.45), [float]$cx, [float]$botY)
    $heartPath.AddBezier([float]$cx, [float]$botY, [float]($cx + $hW * 1.05), [float]($topY + $hH * 0.45), [float]($cx + $hW * 0.7), [float]($topY - $hH * 0.4), [float]$cx, [float]($topY + $hH * 0.3))
    $heartPath.CloseFigure()

    $heartBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.PointF($cx, $topY)),
        (New-Object System.Drawing.PointF($cx, $botY)),
        [System.Drawing.Color]::FromArgb(255, 255, 30, 39),
        [System.Drawing.Color]::FromArgb(255, 130, 0, 16)
    )
    $g.FillPath($heartBrush, $heartPath)
    
    $heartPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 255, 80, 90), [float]($size * 0.015))
    $g.DrawPath($heartPen, $heartPath)
    $heartBrush.Dispose()
    $heartPen.Dispose()
    $heartPath.Dispose()

    # White ECG line
    $ecgPen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, [float]($size * 0.038 * $scale))
    $ecgPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $ecgPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $ecgPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round

    $yMid = [float]$cy
    $p0 = New-Object System.Drawing.PointF([float]($cx - $size * 0.28 * $scale), [float]$yMid)
    $p1 = New-Object System.Drawing.PointF([float]($cx - $size * 0.13 * $scale), [float]$yMid)
    $p2 = New-Object System.Drawing.PointF([float]($cx - $size * 0.06 * $scale), [float]($yMid - $size * 0.16 * $scale))
    $p3 = New-Object System.Drawing.PointF([float]($cx + $size * 0.03 * $scale), [float]($yMid + $size * 0.19 * $scale))
    $p4 = New-Object System.Drawing.PointF([float]($cx + $size * 0.09 * $scale), [float]($yMid - $size * 0.09 * $scale))
    $p5 = New-Object System.Drawing.PointF([float]($cx + $size * 0.14 * $scale), [float]$yMid)
    $p6 = New-Object System.Drawing.PointF([float]($cx + $size * 0.28 * $scale), [float]$yMid)

    $points = [System.Drawing.PointF[]]@($p0, $p1, $p2, $p3, $p4, $p5, $p6)
    $g.DrawLines($ecgPen, $points)
    $ecgPen.Dispose()

    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Created $path"
}

Create-VitalisIcon 192 "icon-192.png" $false
Create-VitalisIcon 512 "icon-512.png" $false
Create-VitalisIcon 512 "icon-maskable.png" $true
Create-VitalisIcon 180 "apple-touch-icon.png" $false
