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

    while ($form.Visible) {
        $random = New-Object System.Random
        $xPos = $random.Next(0, $screenWidth - 300)
        $yPos = $random.Next(0, $screenHeight - 200)

        $form.Location = New-Object System.Drawing.Point($xPos, $yPos)

        Start-Sleep -Seconds 0.5
    }

    Show-RandomMessageBox
}

Show-RandomMessageBox
