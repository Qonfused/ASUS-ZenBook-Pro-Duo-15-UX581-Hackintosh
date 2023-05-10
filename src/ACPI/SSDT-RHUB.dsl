/*
 * Disables native USB controller for manual remapping in macOS.
 * @see https://dortania.github.io/Getting-Started-With-ACPI/Universal/rhub.html
 */
DefinitionBlock ("", "SSDT", 2, "UX582", "RhubOff", 0x00001000)
{
  External (_SB_.PCI0.XHC_.RHUB, DeviceObj)

  Scope (_SB.PCI0.XHC.RHUB)
  {
    Method (_STA, 0, NotSerialized)
    {
      If (_OSI ("Darwin"))
      {
        Return (Zero)
      }
      Else
      {
        Return (0x0F)
      }
    }
  }
}