/*
 * Fixes shutdown issue due to missing S5 signal.
 * @see https://dortania.github.io/OpenCore-Post-Install/usb/misc/shutdown.html
 */
DefinitionBlock ("", "SSDT", 2, "UX582", "ZPTS", 0x00000000)
{
  External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
  External (ZPTS, MethodObj)

  Method (_PTS, 1, NotSerialized)
  {
    ZPTS (Arg0)
    If ((0x05 == Arg0)) { \_SB.PCI0.XHC.PMEE = Zero }
  }
}