/*
 * Apple DTGP method for injecting device properties.
 * Required for SSDT-TB3 property injection.
 */
DefinitionBlock ("", "SSDT", 2, "UX582", "DTGP", 0x00000000)
{
  Method (DTGP, 5, NotSerialized)
  {
    If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
    {
      If ((Arg1 == One))
      {
        If ((Arg2 == Zero))
        {
          Arg4 = Buffer (One) { 0x03 }
          Return (One)
        }

        If ((Arg2 == One))
        {
          Return (One)
        }
      }
    }

    Arg4 = Buffer (One) { 0x00 }
    Return (Zero)
  }
}