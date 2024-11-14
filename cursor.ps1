Add-Type -AssemblyName System.Windows.Forms

Add-Type @"
using System;
using System.Diagnostics;

public class WindowManager {
    public static void MinimizePowerShellWindow() {
        var process = Process.GetCurrentProcess();
        var mainWindowHandle = process.MainWindowHandle;
        if (mainWindowHandle != IntPtr.Zero) {
            ShowWindow(mainWindowHandle, 2);
        }
    }

    [System.Runtime.InteropServices.DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@
[WindowManager]::MinimizePowerShellWindow()

$screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
$screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height

function Show-RandomMessageBox {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Randomized Message Box"
    $form.Size = New-Object System.Drawing.Size(300, 200)

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Hello from a random position!"
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(50, 80)
    $form.Controls.Add($label)

    $form.Show()

    $random = New-Object System.Random

    while ($form.Visible) {
        $cursorPos = [System.Windows.Forms.Cursor]::Position
        $xPos = $cursorPos.X + $random.Next(50, 200)
        $yPos = $cursorPos.Y + $random.Next(50, 200)

        if ($xPos -gt $screenWidth - 300) { $xPos = $screenWidth - 300 }
        if ($yPos -gt $screenHeight - 200) { $yPos = $screenHeight - 200 }

        $form.Location = New-Object System.Drawing.Point($xPos, $yPos)

        Start-Sleep -Seconds 0.5
    }

    Show-RandomMessageBox
}

Show-RandomMessageBox
